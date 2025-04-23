module "github_workflows" {
  source   = "github.com/evoteum/tofu-modules//github/workflows"
  for_each = local.repositories

  repository               = each.key
  repository_configuration = each.value

  controller_repo_name          = var.repository_name
  reusable_workflows_repository = local.reusable_workflows_repository
}
