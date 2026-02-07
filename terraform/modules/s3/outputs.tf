output "cdn_s3_logging_bucket_id" {
  description = "The ID/name of the CloudFront S3 logging bucket"
  value       = module.cdn_s3_logging_bucket.s3_bucket_id
}

output "cdn_s3_logging_bucket_domain_name" {
  description = "The domain name of the CloudFront S3 logging bucket"
  value       = module.cdn_s3_logging_bucket.s3_bucket_bucket_domain_name
}

output "cdn_s3_logging_bucket_arn" {
  description = "The ARN of the CloudFront S3 logging bucket"
  value       = module.cdn_s3_logging_bucket.s3_bucket_arn
}
