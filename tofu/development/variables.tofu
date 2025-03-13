variable "aws_region" {
  type        = string
  description = "The AWS region to deploy the infrastructure to."
}

variable "organisation" {
  type        = string
  description = "The name of the organisation."
}

variable "quay_url" {
  type        = string
  description = "The URL of the Quay server"
}

variable "repo_name" {
  type        = string
  description = "The name of this repository."
}

variable "repo_url" {
  type        = string
  description = "The HTML URL of this repository"
}

variable "cloudflare_account_id" {
  type = string
  description = "Cloudflare Account ID"
  sensitive = true
}
