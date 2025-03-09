output "workflow_debug" {
  value = {
    for repo, module in module.github_workflows : repo => module.debug
  }
}