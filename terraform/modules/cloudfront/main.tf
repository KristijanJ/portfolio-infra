locals {
  name = "${var.prefix}-cloudfront-${var.environment}"
}

module "cdn" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "~> 6.3"

  aliases             = var.domain_aliases
  comment             = "${var.prefix} CloudFront Distribution - ${var.environment}"
  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  price_class         = var.price_class
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = var.default_root_object

  # CloudFront Access Logging
  logging_config = var.enable_logging ? {
    bucket          = var.logging_bucket
    prefix          = var.logging_prefix
    include_cookies = false
  } : null

  # Origin Access Control for S3
  origin_access_control = {
    s3_oac = {
      description      = "CloudFront access to ${var.bucket_name}"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  # S3 Origin Configuration
  origin = {
    s3 = {
      domain_name               = var.bucket_regional_domain_name
      origin_access_control_key = "s3_oac"
    }
  }

  # Default Cache Behavior
  default_cache_behavior = {
    target_origin_id       = "s3"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true

    use_forwarded_values = false

    cache_policy_id          = data.aws_cloudfront_cache_policy.optimized.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.cors_s3.id
  }

  # Custom Error Responses for SPA routing
  custom_error_response = var.custom_error_responses

  # SSL Certificate
  viewer_certificate = {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  # Geo Restriction (none by default)
  restrictions = {
    geo_restriction = {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = merge(
    {
      Name        = local.name
      Environment = var.environment
      Prefix      = var.prefix
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

# Managed Cache Policy - CachingOptimized
data "aws_cloudfront_cache_policy" "optimized" {
  name = "Managed-CachingOptimized"
}

# Managed Origin Request Policy - CORS-S3Origin
data "aws_cloudfront_origin_request_policy" "cors_s3" {
  name = "Managed-CORS-S3Origin"
}
