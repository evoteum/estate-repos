locals {
  github_variable_attributes = [
    "artifact_type",
    "build_flags",
    "fail_fast",
    "language",
    "language_version",
    "source_path",
    "todo_issue_disabled",
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

  quay_repository_attributes = [
    "path",
    "url",
  ]

  quay_variables = merge([
    for repo in keys(module.quay_repository) : {
      for attribute in local.quay_repository_attributes :
      "${repo}-quay_repository_${attribute}" => {
        scope = repo
        name  = "quay_repository_${attribute}"
        value = lookup(module.quay_repository[repo], attribute, null)
      }
    }
  ]...)

  all_github_variables = merge(
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

  sensitive = false
  scope     = each.value.scope
  name      = each.value.name
  value     = each.value.value
}
