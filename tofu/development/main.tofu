terraform {
  required_version = "1.9.0"
  backend "s3" {
    # Values provided by -backend-config in CI
    bucket = ""
    key    = ""
    region = ""
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.1.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    quay = {
      source = "registry.terraform.io/enthought/quay"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment   = local.environment
      Project       = var.repository_name
      ManagedBy     = "OpenTofu"
      RepositoryURL = var.repository_url
    }
  }
}

provider "cloudflare" {
}

provider "github" {
  owner = var.organisation
  # Using `GITHUB_APP_XXX` environment variables in CI
  app_auth {}
}

provider "quay" {
  url = var.quay_url
}
