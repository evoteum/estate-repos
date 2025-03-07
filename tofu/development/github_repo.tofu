module "github_repository" {
  source   = "github.com/evoteum/tofu-modules//github/repo"
  for_each = local.repositories

  name        = each.key
  description = each.value.description

  archived             = lookup(each.value, "archived", null)
  has_discussions      = lookup(each.value, "has_discussions", null)
  has_issues           = lookup(each.value, "has_issues", null)
  has_projects         = lookup(each.value, "has_projects", null)
  has_wiki             = lookup(each.value, "has_wiki", null)
  homepage_url         = lookup(each.value, "homepage_url", null)
  management_repo_name = var.repo_name
  management_repo_url  = var.repo_url
  organisation         = var.organisation
  topics               = lookup(each.value, "topics", null)
  visibility           = lookup(each.value, "visibility", null)
}
