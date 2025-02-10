variable "aws_region" {
    type        = string
    description = "The AWS region to deploy the infrastructure to."
    sensitive   = false
}

variable "org_name" {
    type        = string
    description = "The name of the organisation."
    sensitive   = false
}

variable "repo_name" {
    type        = string
    description = "The name of the repository."
    sensitive   = false
}
