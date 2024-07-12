resource "cloudflare_zone" "this" {
  zone       = var.domain_name
  account_id = var.account_id
  plan       = "free"
}

resource "cloudflare_email_routing_settings" "this" {
  zone_id = cloudflare_zone.this.id
  enabled = "true"
}
