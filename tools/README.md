# terraform-tools

```hcl
module "utilities" {
  source = "git@github.com:artdolya/terraform.git/tools"
}

locals {
  tags = {
    Created          = module.utilities.timestamp
    TerraformVersion = module.utilities.terraform_version
  }
}
```