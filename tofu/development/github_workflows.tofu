module "github_workflows" {
  source   = "github.com/evoteum/tofu-modules//github/workflows"
  for_each = local.repositories

  repository                    = each.key
  artifact_type                 = lookup(each.value, "artifact_type", null)
  controller_repo_name          = lookup(each.value, "controller_repo_name", null)
  language                      = lookup(each.value, "language", null)
  language_version              = lookup(each.value, "language_version", null)
  linters                       = lookup(each.value, "linters", null)
  needs_tofu                    = lookup(each.value, "needs_tofu", null)
  reusable_workflows_repository = lookup(each.value, "reusable_workflows_repository", null)
  source_path                   = lookup(each.value, "source_path", null)
  todo_issue_disabled           = lookup(each.value, "todo_issue_disabled", null)
  workflow_definitions          = lookup(each.value, "workflow_definitions", null)
}
