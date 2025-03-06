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
      "${repo}-quay_repo_path" = {
        scope = repo
        name  = "quay_repo_path"
        value = module.quay_repository[repo].path
      }
    }
  ]...)

  quay_repo_url_variables = merge([
    for repo in keys(module.quay_repository) : {
      "${repo}-quay_repo_url" = {
        scope = repo
        name  = "quay_repo_path"
        value = module.quay_repository[repo].url
      }
    }
  ]...)

  all_github_variables = merge(
    local.github_variables,
    local.quay_repo_path_variables,
    local.quay_repo_url_variables,
  )
}

module "github_variable" {
  source   = "github.com/evoteum/tofu-modules.git//github/variable"
  for_each = local.all_github_variables
  depends_on = [
    module.quay_repository
  ]

  sensitive = false
  scope     = each.value.scope
  name      = upper(each.value.name)
  value     = each.value.value
}
