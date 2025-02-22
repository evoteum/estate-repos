module "github_repository" {
  source   = "github.com/evoteum/tofu-modules.git//github/repo"
  for_each = local.repositories

  repo_name        = each.key
  repo_description = each.value.description

  visibility                  = lookup(each.value, "visibility", null)
  homepage_url                = lookup(each.value, "homepage_url", null)
  has_discussions             = lookup(each.value, "has_discussions", null)
  has_projects                = lookup(each.value, "has_projects", null)
  has_wiki                    = lookup(each.value, "has_wiki", null)
  topics                      = lookup(each.value, "topics", null)
  archived                    = lookup(each.value, "archived", null)
  management_repo_name        = var.repo_name
  management_repo_url         = var.repo_url
}
