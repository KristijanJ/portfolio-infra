terraform {
  required_version = "~> 1.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.30"
    }
  }

  backend "s3" {
    bucket       = "terraform-jovanovski-dev"
    key          = "environments/prod/terraform.tfstate"
    region       = "eu-central-1"
    use_lockfile = true
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      Prefix = var.prefix
      Environment = var.environment
    }
  }
}

# CloudFront requires ACM certificates to be in us-east-1
provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = var.profile
}
