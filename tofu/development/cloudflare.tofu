locals {
  required_cloudflare_zones = {
    for repository, configuration in local.repositories :
    repository => split("/", trimprefix(trimprefix(configuration.homepage_url, "http://"), "https://"))[0]
    if try(configuration.homepage_url, null) != null
  }
}

module "cloudflare_zone" {
  source   = "github.com/evoteum/tofu-modules//cloudflare/zone"
  for_each = local.required_cloudflare_zones

  account_id  = var.cloudflare_account_id
  domain_name = each.value
}
