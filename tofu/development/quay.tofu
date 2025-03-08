locals {
  quay_attributes = [
    "archived",
    "description",
    "visibility",
  ]

  quay_repository_variables = {
    for repo, config in local.repositories : repo => {
      for attribute in local.quay_attributes :
      attribute => lookup(config, attribute, null)
    } if lookup(config, "artefact_type", null) == "container"
  }
}
module "quay_repository" {
  source   = "github.com/evoteum/tofu-modules//quay/repo"
  for_each = local.quay_repository_variables

  name         = each.key
  organisation = var.organisation
  visibility   = module.github_repository[each.key].visibility
  description = join("", [
    coalesce(each.value.archived, false) ? "Archived: " : "",
    each.value.description,
    " ",
    module.github_repository[each.key].html_url
  ])
}
