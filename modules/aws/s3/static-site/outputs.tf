# Output variable definitions

output "arn" {
  description = "ARN of the bucket"
  value       = module.website_bucket.arn
}

output "name" {
  description = "Name (id) of the bucket"
  value       = module.website_bucket.id
}

output "domain" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket_website_configuration.website.website_domain
}
