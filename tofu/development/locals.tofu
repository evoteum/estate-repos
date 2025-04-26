locals {
  repositories                  = yamldecode(file("${path.module}/../../repos.yml"))
  reusable_workflows_repository = "estate-reusable-workflows"
  environment                   = basename(abspath(path.module))

  repository_homepage_urls = {
    for repository, configuration in local.repositories :
    repository => configuration.homepage_url
    if try(configuration.homepage_url, null) != null
  }
}
