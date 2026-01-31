# ============================================================================
# General Configuration
# ============================================================================
prefix      = "portfolio"
environment = "prod"
region      = "eu-central-1"

# Optional: Uncomment and set your AWS profile for local development
# profile = "your-aws-profile-name"

# ============================================================================
# CloudFront Configuration
# ============================================================================

# Your domain name
domain_alias = "your-domain.com"

# ACM Certificate ARN (must be in us-east-1 region for CloudFront)
acm_certificate_arn = "arn:aws:acm:us-east-1:ACCOUNT_ID:certificate/CERTIFICATE_ID"
