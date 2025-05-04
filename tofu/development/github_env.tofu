locals {
  all_repositories = {
    for name in concat(
      keys(local.repositories),
      ["estate-repos"]
    ) : name => true
  }
}

module "github_tofu_env" {
  source   = "github.com/evoteum/tofu-modules//github/tofu_env"
  for_each = local.all_repositories

  repository_name      = each.key
  repository_owner     = var.organisation
}
