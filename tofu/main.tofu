terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.45.0"
    }
  }
  required_version = "1.9.0"
  backend "s3" {
    # These are all provided in CD, so these values are just placeholders.
    bucket = "tofu-state-*****"
    key    = "repo_name/tofu.tfstate"
    region = "AWS_REGION"
  }
}

provider "aws" {
  region = var.aws_region
}

provider "github" {
  owner = var.org_name
  app_auth {} # Using `GITHUB_APP_XXX` environment variables in CI
}
