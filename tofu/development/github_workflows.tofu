module "github_workflows" {
  source   = "github.com/evoteum/tofu-modules//github/workflows"
  for_each = local.repositories

  repository          = each.key
  artifact_type       = lookup(each.value, "artifact_type", null)
  language            = lookup(each.value, "language", null)
  language_version    = lookup(each.value, "language_version", null)
  linters             = lookup(each.value, "linters", null)
  needs_tofu          = lookup(each.value, "needs_tofu", null)
  source_path         = lookup(each.value, "source_path", null)
  todo_issue_disabled = lookup(each.value, "todo_issue_disabled", null)
}
