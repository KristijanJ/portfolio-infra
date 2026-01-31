output "cloudfront_distribution_id" {
  description = "The identifier for the CloudFront distribution"
  value       = module.cdn.cloudfront_distribution_id
}

output "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  value       = module.cdn.cloudfront_distribution_arn
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.cdn.cloudfront_distribution_domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  description = "The CloudFront Route 53 zone ID"
  value       = module.cdn.cloudfront_distribution_hosted_zone_id
}

output "cloudfront_distribution_status" {
  description = "The current status of the distribution"
  value       = module.cdn.cloudfront_distribution_status
}

output "cloudfront_distribution_etag" {
  description = "The current version of the distribution's information"
  value       = module.cdn.cloudfront_distribution_etag
}

output "cloudfront_origin_access_controls" {
  description = "The origin access controls created"
  value       = module.cdn.cloudfront_origin_access_controls
}
