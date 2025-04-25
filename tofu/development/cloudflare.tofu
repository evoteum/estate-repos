module "cloudflare_zone" {
  source   = "github.com/evoteum/tofu-modules//cloudflare/zone"
  for_each = local.repository_homepage_urls

  account_id  = var.cloudflare_account_id
  domain_name = each.value
}

module "cloudflare_record" {
  source   = "github.com/evoteum/tofu-modules//cloudflare/record"
  for_each = local.all_dns_records

  zone_id      = each.value.zone_id
  name         = each.value.name
  type         = each.value.type
  value        = each.value.value
  proxied      = each.value.proxied
  time_to_live = each.value.ttl
  tags = {
    repository_url = var.repository_url
    ManagedBy      = "OpenTofu"
  }
}
