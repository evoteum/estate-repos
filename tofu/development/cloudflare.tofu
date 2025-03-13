locals {
  required_cloudflare_zones = toset([
    for configuration in values(local.repositories) :
    split("/", trimprefix(trimprefix(try(configuration.homepage_url, ""), "http://"), "https://"))[0]
    if try(configuration.homepage_url, null) != null
  ])
}

module "cloudflare_zone" {
  source   = "github.com/evoteum/tofu-modules//cloudflare/zone"
  for_each = local.repositories

  account_id  = var.cloudflare_account_id
  domain_name = each.value
}
