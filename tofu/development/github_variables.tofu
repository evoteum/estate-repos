locals {
  github_variable_attributes = {
    archived         = false
    build_flags      = null
    description      = null
    fail_fast        = true
    language         = null
    language_version = null
    source_path      = null
    visibility       = "public"
  }

  github_variables = merge([
    for repo, config in local.repositories : {
      for attribute_key, attribute_default in local.github_variable_attributes :
      "${repo}-${attribute_key}" => {
        scope     = repo
        name      = "repository_${attribute_key}"
        value     = lookup(config, attribute_key, attribute_default)
        sensitive = false
      } if (
      contains(keys(config), attribute_key)
      || attribute_default != null
    )
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