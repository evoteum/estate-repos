locals {
  repositories                  = yamldecode(file("${path.module}/../../repos.yml"))
  reusable_workflows_repository = "estate-reusable-workflows"
  environment                   = basename(abspath(path.module))

  #   certificate_dns_records = merge([
  #     for repo, cert in module.aws_certificate : {
  #       for domain, dvo in cert.domain_validation_options :
  #       "${repo}-${domain}" => {
  #         zone_id = module.cloudflare_zone[repo].id
  #         name    = dvo.name
  #         type    = dvo.type
  #         value   = dvo.value
  #         proxied = false
  #         ttl     = 60
  #       }
  #     }
  #   ]...)

  #   all_dns_records = merge(
  #     local.certificate_dns_records
  #   )
  repository_homepage_urls = {
    for repository, configuration in local.repositories :
    repository => configuration.homepage_url
    if try(configuration.homepage_url, null) != null
  }
}
