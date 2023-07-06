data "external" "terraform_version" {
  program = ["bash", "${path.module}/scripts/get_terraform_version.sh"]
}

data "external" "timestamp" {
  program = ["bash", "${path.module}/scripts/get_timestamp.sh"]
}
