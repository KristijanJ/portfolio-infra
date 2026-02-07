module "cdn_s3_logging_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.10"

  bucket = var.cdn_s3_logging_bucket_name

  # Block public access (defaults to true, but explicitly set for clarity)
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # Enable versioning for audit trail
  versioning = {
    enabled = true
  }

  # Lifecycle rules to manage log retention
  lifecycle_rule = [
    {
      id      = "delete-old-logs"
      enabled = true

      expiration = {
        days = 90
      }

      noncurrent_version_expiration = {
        days = 30
      }
    }
  ]

  # Server-side encryption
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  # Enable bucket ownership controls (required for CloudFront logging)
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  # ACL for CloudFront logging
  acl = "log-delivery-write"
}
