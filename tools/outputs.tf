output "terraform_version" {
  value = "v${data.external.terraform_version.result.version}"
}

output "timestamp" {
  value = data.external.timestamp.result.current
}
