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
    } if lookup(config, "artifact_type", null) == "container"
  }
  quay_enabled = false
}
# temporary changes because quay repos were deleted manually.
module "quay_repository" {
  source   = "github.com/evoteum/tofu-modules.git//quay/repo"
  for_each = local.quay_enabled ? local.quay_repository_variables : {}

  name         = local.quay_enabled ? each.key : ""
  organisation = local.quay_enabled ? var.organisation : ""
  visibility   = local.quay_enabled ? module.github_repository[each.key].visibility : "public"
  description = local.quay_enabled ? join("", [
    coalesce(each.value.archived, false) ? "Archived: " : "",
    each.value.description,
    " ",
    module.github_repository[each.key].html_url
  ]) : ""
}

removed {
  from = module.quay_repository
}