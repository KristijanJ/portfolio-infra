# ============================================================================
# CloudFront Outputs
# ============================================================================

output "cloudfront_distribution_id" {
  description = "The identifier for the CloudFront distribution"
  value       = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_distribution_arn
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_distribution_domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  description = "The CloudFront Route 53 zone ID (for creating Route53 alias records)"
  value       = module.cloudfront.cloudfront_distribution_hosted_zone_id
}

output "cloudfront_distribution_status" {
  description = "The current status of the distribution"
  value       = module.cloudfront.cloudfront_distribution_status
}

# ============================================================================
# S3 Bucket Outputs
# ============================================================================

output "s3_bucket_id" {
  description = "The name of the S3 bucket"
  value       = data.aws_s3_bucket.website.id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = data.aws_s3_bucket.website.arn
}

output "s3_bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  value       = data.aws_s3_bucket.website.bucket_regional_domain_name
}
