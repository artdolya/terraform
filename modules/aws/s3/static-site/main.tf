locals {
  content_types = {
    ".html" : "text/html",
    ".css" : "text/css",
    ".js" : "text/javascript"
  }
}

module "website_bucket" {
  source      = "../s3-bucket"
  bucket_name = var.bucket_name

  tags          = var.tags
  public_access = true
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = module.website_bucket.id

  index_document {
    suffix = var.default_index_page
  }

  error_document {
    key = var.default_error_page
  }
}

resource "aws_s3_object" "site_files" {
  for_each     = fileset(var.source_dir, "*")
  bucket       = module.website_bucket.id
  key          = each.value
  content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), null)
  source       = "${var.source_dir}/${each.value}"
  etag         = filemd5("${var.source_dir}/${each.value}")
  tags         = var.tags
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.website_bucket.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "PublicReadGetObject",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "s3:GetObject",
          "Resource" : "arn:aws:s3:::${module.website_bucket.id}/*"
        }
      ]
    }
  )
}
