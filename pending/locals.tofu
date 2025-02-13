locals {
    repositories = from_yaml(file("${path.module}/../repositories.yaml"))

}