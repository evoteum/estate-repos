locals {
  github_variable_attributes = [
    "build_flags",
    "description",
    "fail_fast",
    "language",
    "language_version",
    "source_path",
    "visibility",
  ]

  github_variables = merge([
    for repo, config in local.repositories : {
      for attribute in local.github_variable_attributes :
      "${repo}-${attribute}" => {
        scope     = repo
        name      = "repository_${attribute}"
        value     = lookup(config, attribute, null)
        sensitive = false
      } if lookup(config, attribute, null) != null
    }
  ]...)

  all_github_variables = merge(
    local.github_variables,
  )

  repository_id_map = merge(
    {
      (var.repository_name) = data.github_repository.this.repo_id
    },
    {
      for name, mod in module.github_repository :
      name => mod.id
    }
  )

}

module "github_variable" {
  source   = "github.com/evoteum/tofu-modules//github/variable"
  for_each = local.all_github_variables

  sensitive = each.value.sensitive
  scope     = each.value.scope
  name      = each.value.name
  value     = each.value.value
}

module "github_set_repository_id" {
  for_each        = local.repository_id_map
  source          = "github.com/evoteum/tofu-modules//github/set_repository_id"
  repository_name = each.key
  repository_id   = each.value
}
