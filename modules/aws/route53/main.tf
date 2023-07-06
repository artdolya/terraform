resource "aws_route53_zone" "this" {
  name = var.domain_name
  tags = var.tags
}

module "ssl_cert" {
  source = "../acm"
  count  = var.create_certificate ? 1 : 0

  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = var.validation_method
  zone_id                   = aws_route53_zone.this.id
  tags                      = var.tags
}
