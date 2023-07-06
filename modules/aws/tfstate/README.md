# HOW TO

```terraform
module "terraform_state" {
  source      = "git@github.com:artdolya/terraform.git//modules/aws/tfstate"
  table_name  = local.table_name
  bucket_name = local.bucket_name
}
```