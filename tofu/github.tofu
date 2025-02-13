module "github_repository" {
  source   = "github.com/evoteum/tofu-modules.git//github/repo"
  for_each = local.repositories

  repo_name        = each.key
  repo_description = each.value.description
  visibility       = each.value.visibility

  homepage_url    = lookup(each.value, "homepage_url", null)
  has_issues      = lookup(each.value, "has_issues", null)
  has_discussions = lookup(each.value, "has_discussions", null)
  has_projects    = lookup(each.value, "has_projects", null)
  has_wiki        = lookup(each.value, "has_wiki", null)
  has_downloads   = lookup(each.value, "has_downloads", null)

  allow_merge_commit = lookup(each.value, "allow_merge_commit", null)
  allow_squash_merge = lookup(each.value, "allow_squash_merge", null)
  allow_rebase_merge = lookup(each.value, "allow_rebase_merge", null)
  allow_auto_merge   = lookup(each.value, "allow_auto_merge", null)

  squash_merge_commit_title   = lookup(each.value, "squash_merge_commit_title", null)
  squash_merge_commit_message = lookup(each.value, "squash_merge_commit_message", null)
  merge_commit_title          = lookup(each.value, "merge_commit_title", null)
  merge_commit_message        = lookup(each.value, "merge_commit_message", null)

  delete_branch_on_merge = lookup(each.value, "delete_branch_on_merge", null)
  gitignore_template     = lookup(each.value, "gitignore_template", null)
  license_template       = lookup(each.value, "license_template", null)
  vulnerability_alerts   = lookup(each.value, "vulnerability_alerts", null)
  topics                 = lookup(each.value, "topics", null)
}
