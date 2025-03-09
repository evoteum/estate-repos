module "github_workflows" {
  source   = "github.com/evoteum/tofu-modules//github/workflows"
  for_each = local.repositories

  repository               = each.key
  repository_configuration = each.value

  controller_repo_name          = var.repo_name
  reusable_workflows_repository = local.reusable_workflows_repository
}

output "debug_github_workflows_repository_configuration" {
  value = module.github_workflows["testy-mctestface"].repository_configuration
}


output "debug_github_workflows_workflow_conditions" {
  value = module.github_workflows["testy-mctestface"].workflow_conditions
}

output "debug_github_workflows_workflow_evaluations" {
  value = module.github_workflows["testy-mctestface"].workflow_evaluations
}