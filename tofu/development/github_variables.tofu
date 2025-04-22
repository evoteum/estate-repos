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

#   cloudflare_zone_variables = {
#     for repo in keys(local.required_cloudflare_zones) :
#     "${repo}-cloudflare_zone_id" => {
#       scope     = repo
#       name      = "cloudflare_zone_id"
#       value     = module.cloudflare_zone[repo].id
#       sensitive = true
#     }
#   }

  all_github_variables = merge(
#     local.cloudflare_zone_variables,
    local.github_variables,
    local.quay_variables,
  )
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
