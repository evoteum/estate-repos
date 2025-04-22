locals {
  required_cloudflare_zones = {
    for repository, configuration in local.repositories :
    repository => split("/", trimprefix(trimprefix(configuration.homepage_url, "http://"), "https://"))[0]
    if try(configuration.homepage_url, null) != null
  }

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

  all_dns_records = merge(
    local.certificate_dns_records
  )

}

# module "cloudflare_zone" {
#   source   = "github.com/evoteum/tofu-modules//cloudflare/zone"
#   for_each = local.required_cloudflare_zones
#
#   account_id  = var.cloudflare_account_id
#   domain_name = each.value
# }
#
# module "cloudflare_record" {
#   source   = "github.com/evoteum/tofu-modules//cloudflare/record"
#   for_each = local.all_dns_records
#
#   zone_id       = each.value.zone_id
#   name          = each.value.name
#   type          = each.value.type
#   value         = each.value.value
#   proxied       = each.value.proxied
#   time_to_live  = each.value.ttl
#   tags = {
#     repository_url: var.repository_url
#   }
# }
