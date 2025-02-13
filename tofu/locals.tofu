locals {
  repositories = yamldecode(file("${path.module}/../repositories.yaml"))

}