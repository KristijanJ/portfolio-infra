variable "prefix" {
  description = "The prefix for all resources"
  type        = string
}

variable "environment" {
  description = "The environment (dev, staging, prod)"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket to use as origin"
  type        = string
}

variable "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket (e.g., bucket-name.s3.region.amazonaws.com)"
  type        = string
}

variable "domain_aliases" {
  description = "List of domain aliases for the CloudFront distribution"
  type        = list(string)
  default     = []
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS (must be in us-east-1)"
  type        = string
}

variable "default_root_object" {
  description = "The object that CloudFront returns when an end user requests the root URL"
  type        = string
  default     = "index.html"
}

variable "price_class" {
  description = "The price class for the CloudFront distribution"
  type        = string
  default     = "PriceClass_100"
}

variable "enabled" {
  description = "Whether the distribution is enabled"
  type        = bool
  default     = true
}

variable "is_ipv6_enabled" {
  description = "Whether IPv6 is enabled for the distribution"
  type        = bool
  default     = true
}

variable "custom_error_responses" {
  description = "Custom error response configuration for SPA routing"
  type = list(object({
    error_code            = number
    response_code         = number
    response_page_path    = string
    error_caching_min_ttl = number
  }))
  default = [
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
}

variable "tags" {
  description = "Additional tags for the CloudFront distribution"
  type        = map(string)
  default     = {}
}

variable "logging_bucket" {
  description = "The S3 bucket for CloudFront access logs (bucket.s3.amazonaws.com format)"
  type        = string
  default     = ""
}

variable "logging_prefix" {
  description = "Prefix for CloudFront access logs in the S3 bucket"
  type        = string
  default     = "cloudfront/"
}

variable "enable_logging" {
  description = "Whether to enable CloudFront access logging"
  type        = bool
  default     = false
}
