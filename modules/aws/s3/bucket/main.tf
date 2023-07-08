resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "website_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  ignore_public_acls      = !var.public_access
  block_public_acls       = !var.public_access
  restrict_public_buckets = !var.public_access
  block_public_policy     = !var.public_access
}
