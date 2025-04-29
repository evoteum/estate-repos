locals {
  github_variable_attributes = [
    "artefact_type",
    "build_flags",
    "fail_fast",
    "language",
    "language_version",
    "source_path",
  ]

  github_variables = merge([
    for repo, config in local.repositories : {
      for attribute in local.github_variable_attributes :
      "${repo}-${attribute}" => {
        scope     = repo
        name      = attribute
        value     = lookup(config, attribute, null)
        sensitive = false
      } if lookup(config, attribute, null) != null
    }
  ]...)

  quay_repository_attributes = [
    "path",
    "url",
  ]

  quay_variables = merge([
    for repo in keys(module.quay_repository) : {
      for attribute in local.quay_repository_attributes :
      "${repo}-quay_repository_${attribute}" => {
        scope     = repo
        name      = "quay_repository_${attribute}"
        value     = lookup(module.quay_repository[repo], attribute, null)
        sensitive = false
      }
    }
  ]...)

  cloudflare_zone_variables = {
    for repo in keys(local.repository_homepage_urls) :
    "${repo}-cloudflare_zone_id" => {
      scope     = repo
      name      = "cloudflare_zone_id"
      value     = module.cloudflare_zone[repo].id
      sensitive = true
    }
  }

  certificate_variables = {
    for repo in keys(local.repository_homepage_urls) :
    "${repo}-certificate_arn" => {
      scope     = repo
      name      = "certificate_arn"
      value     = module.aws_certificate[repo].certificate_arn
      sensitive = true
    }
  }

  all_github_variables = merge(
    local.certificate_variables,
    local.cloudflare_zone_variables,
    local.github_variables,
    local.quay_variables,
  )

  all_repositories = toset(concat(
    keys(local.repositories),
    ["estate-repos"],
  ))
}

module "github_variable" {
  source   = "github.com/evoteum/tofu-modules//github/variable"
  for_each = local.all_github_variables
  depends_on = [
    module.quay_repository
  ]

  sensitive = each.value.sensitive
  scope     = each.value.scope
  name      = each.value.name
  value     = each.value.value
}

module "github_set_repository_id" {
  for_each        = local.all_repositories
  source          = "github.com/evoteum/tofu-modules//github/set_repository_id"
  repository_name = each.key
  depends_on = [module.github_repository]
}
