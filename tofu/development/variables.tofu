variable "aws_region" {
  type        = string
  description = "The AWS region to deploy the infrastructure to."
}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare Account ID"
  sensitive   = true
}

variable "organisation" {
  type        = string
  description = "The name of the organisation."
}

variable "quay_url" {
  type        = string
  description = "The URL of the Quay server"
}

variable "repository_id" {
  type        = string
  description = "The GitHub API ID of this repository."
}

variable "repository_name" {
  type        = string
  description = "The name of this repository."
}

variable "repository_url" {
  type        = string
  description = "The HTML URL of this repository"
}

variable "production_alb_dns_name" {
  type        = string
  description = "The DNS name of the production load balancer"
}