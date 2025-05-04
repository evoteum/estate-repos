locals {
  all_repositories = concat(
    keys(local.repositories),
    ["estate-repos"],
  )
}

module "github_tofu_env" {
  source   = "github.com/evoteum/tofu-modules//github/tofu_env"
  for_each = local.repositories

  repository_name      = each.key
  repository_owner     = var.organisation
}
