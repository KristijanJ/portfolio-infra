variable "prefix" {
  description = "The prefix for all resources"
  type        = string
}

variable "environment" {
  description = "The environment (dev, staging, prod)"
  type        = string
}

variable "cdn_s3_logging_bucket_name" {
  description = "The name of the S3 bucket for CloudFront access logs"
  type        = string
}
