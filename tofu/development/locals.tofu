locals {
  repositories                  = yamldecode(file("${path.module}/../../repos.yml"))
  reusable_workflows_repository = "estate-reusable-workflows"
  environment                   = basename(abspath(path.module))

}
