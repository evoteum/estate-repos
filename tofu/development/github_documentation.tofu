locals {
  auto_docs_repositories = {
    for repository, configuration in local.repositories :
    repository => configuration
    if try(configuration.needs_auto_docs, null) != null
  }
}

module "github_documentation" {
  source   = "github.com/evoteum/tofu-modules//github/documentation"
  for_each = local.auto_docs_repositories

  repository_name      = each.key
  repository_owner     = var.organisation
  artefact_type        = lookup(each.value, "artefact_type", null)
  management_repo_name = var.management_repo_name
  management_repo_url  = var.management_repo_url
  quay_repository_url  = lookup(each.value, "artefact_type", null) == "container" ? module.quay_repository[each.value].url : null

}

