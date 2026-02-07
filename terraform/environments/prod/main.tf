# ============================================================================
# Data Sources
# ============================================================================

# Reference the existing S3 bucket
data "aws_s3_bucket" "website" {
  bucket = var.domain_alias
}

# ============================================================================
# S3 Logging Bucket for CloudFront
# ============================================================================

module "s3" {
  source = "../../modules/s3"

  prefix      = var.prefix
  environment = var.environment

  cdn_s3_logging_bucket_name = "${var.prefix}-cloudfront-logs-${var.environment}"
}

# ============================================================================
# CloudFront Distribution
# ============================================================================

module "cloudfront" {
  source = "../../modules/cloudfront"

  prefix      = var.prefix
  environment = var.environment

  # S3 Bucket Configuration
  bucket_name                 = data.aws_s3_bucket.website.id
  bucket_regional_domain_name = data.aws_s3_bucket.website.bucket_regional_domain_name

  # Domain Configuration
  domain_aliases = [var.domain_alias]

  # ACM Certificate (must exist in us-east-1)
  acm_certificate_arn = var.acm_certificate_arn

  # CloudFront Settings
  default_root_object = "index.html"
  price_class         = "PriceClass_100"
  enabled             = true
  is_ipv6_enabled     = true

  # CloudFront Access Logging
  enable_logging = true
  logging_bucket = module.s3.cdn_s3_logging_bucket_domain_name
  logging_prefix = "cloudfront/"

  # Custom error responses for SPA routing
  custom_error_responses = [
    {
      error_code            = 403
      response_code         = 200
      response_page_path    = "/index.html"
      error_caching_min_ttl = 0
    },
    {
      error_code            = 404
      response_code         = 200
      response_page_path    = "/index.html"
      error_caching_min_ttl = 0
    }
  ]

  tags = {
    Project     = "Portfolio"
    Environment = var.environment
  }
}

# ============================================================================
# S3 Bucket Policy for CloudFront Access
# ============================================================================

resource "aws_s3_bucket_policy" "website_cloudfront_access" {
  bucket = data.aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${data.aws_s3_bucket.website.arn}/*"
        Condition = {
          StringEquals = {
            "aws:SourceArn" = module.cloudfront.cloudfront_distribution_arn
          }
        }
      }
    ]
  })
}
