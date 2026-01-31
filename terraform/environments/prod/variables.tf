# ============================================================================
# General Configuration
# ============================================================================
variable "prefix" {
  description = "The prefix for all resources"
  default     = "portfolio"
}

variable "environment" {
  description = "The environment (dev, staging, prod)"
  default     = "prod"
}

variable "region" {
  description = "The aws region"
  default     = "eu-central-1"
}

variable "profile" {
  description = "The aws profile"
  default     = null
  nullable    = true
}

# ============================================================================
# CloudFront Configuration
# ============================================================================
variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS (must be in us-east-1)"
  type        = string
}

variable "domain_alias" {
  description = "Domain alias for the CloudFront distribution"
  type        = string
}
