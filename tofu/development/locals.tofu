locals {
  repositories = yamldecode(file("${path.module}/../../repos.yml"))
}
