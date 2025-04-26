locals {
  certificate_dns_records = merge([
    for repo, cert in module.aws_certificate : {
      for domain, dvo in cert.domain_validation_options :
      "${repo}-${domain}" => {
        zone_id = module.cloudflare_zone[repo].id
        name    = dvo.name
        type    = dvo.type
        value   = dvo.value
        proxied = false
        ttl     = 60
      }
    }
  ]...)

  alb_dns_records = {
    for repository, homepage_url in local.repository_homepage_urls : repository => {
      zone_id = module.cloudflare_zone[repository].id
      name    = "www"
      type    = "CNAME"
      value   = var.production_alb_dns_name
      proxied = false
      ttl     = 60
    }
  }

  all_dns_records = merge(
    local.certificate_dns_records,
    local.alb_dns_records,
  )
}

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

resource "cloudflare_page_rule" "redirect_root_to_www" {
  for_each = {
    for repo, config in local.repositories :
    repo => config
    if try(config.type, "") != "redirect" && try(config.homepage_url, null) != null
  }

  zone_id = module.cloudflare_zone[each.key].id
  target  = "${provider::netparse::parse_url(each.value.homepage_url)}/*"

  actions {
    forwarding_url {
      url         = "${provider::netparse::parse_url(each.value.homepage_url)}/$1"
      status_code = 301
    }
  }

  priority = 1
}

