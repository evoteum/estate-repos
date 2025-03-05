locals {
  github_variable_attributes = [
    "source_path",
    "fail_fast",
    "language",
    "language_version",
    "artifact_type",
    "build_flags"
  ]

  github_variables = merge([
    for repo, config in local.repositories : {
      for attribute in local.github_variable_attributes :
      "${repo}-${attribute}" => {
        scope = repo
        name  = attribute
        value = lookup(config, attribute, null)
      } if lookup(config, attribute, null) != null
    }
  ]...)

  quay_repo_path_variables = merge([
    for repo in keys(module.quay_repository) : {
      repo = {
        scope = repo
        name  = "quay_repo_path"
        value = module.quay_repository[repo].path
      }
    } if contains(keys(local.repositories), repo)
  ]...)

  quay_repo_url_variables = local.quay_enabled ? merge([
    for repo in keys(module.quay_repository) : {
      repo = {
        scope = repo
        name  = "quay_repo_url"
        value = module.quay_repository[repo].url
      }
    } if contains(keys(local.repositories), repo)
  ]...) : {}

  all_github_variables = merge(
    local.github_variables,
    local.quay_repo_path_variables,
    local.quay_repo_url_variables,
  )

}


module "github_variable" {
  source   = "github.com/evoteum/tofu-modules.git//github/variable"
  for_each = local.all_github_variables

  sensitive = false
  scope     = each.value.scope
  name      = upper(each.value.name)
  value     = each.value.value
}