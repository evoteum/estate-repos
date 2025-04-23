locals {
  deployment_repositories = {
    for name, repo in local.repositories :
    name => repo
    if try(repo.deploy, false)
  }


}

module "aws_certificate" {
  source = "github.com/evoteum/tofu-modules//aws/certificate"

  for_each = local.repository_hostnames

  domain_name               = each.value
}


output "repository_hostnames" {
  value = local.repository_hostnames
}