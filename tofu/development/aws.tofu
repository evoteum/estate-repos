locals {
  deployment_repositories = {
    for name, repo in local.repositories :
    name => repo
    if try(repo.deploy, false)
  }


}

module "aws_certificate" {
  source = "github.com/evoteum/tofu-modules//aws/certificate"

  for_each = local.repository_homepage_urls

  domain_name               = each.value
}


output "repository_homepage_urls" {
  value = local.repository_homepage_urls
}

resource "aws_acm_certificate_validation" "this" {
  for_each = local.repository_homepage_urls

  certificate_arn = module.aws_certificate[each.key].certificate_arn

  validation_record_fqdns = [
    for dvo in values(module.aws_certificate[each.key].domain_validation_options) :
    dvo.name
  ]
  depends_on = [
    module.cloudflare_record
  ]
}