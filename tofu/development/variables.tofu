variable "aws_region" {
  type        = string
  description = "The AWS region to deploy the infrastructure to."
  sensitive   = false
}

variable "organisation" {
  type        = string
  description = "The name of the organisation."
  sensitive   = false
}

variable "quay_url" {
  type        = string
  description = "The URL of the Quay server"
}

variable "repo_name" {
  type        = string
  description = "The name of this repository."
  sensitive   = false
}

variable "repo_url" {
  type        = string
  description = "The HTML URL of this repository"
}
