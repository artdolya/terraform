resource "random_id" "tunnel_secret" {
  byte_length = 32
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "this" {
  account_id = var.cloudflare_account_id
  name       = var.tunnel_name
  tunnel_secret = random_id.tunnel_secret.b64_std
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "this" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id

  # In your provider version, "config" is an ATTRIBUTE, not a block.
  config = {
    ingress = [
      {
        hostname = var.hostname
        service  = var.origin_service
        origin_request = {
          http_host_header = var.hostname
        }
      },
      {
        service = "http_status:404"
      }
    ]
  }
}
resource "cloudflare_dns_record" "tunnel_cname" {
  zone_id = var.cloudflare_zone_id
  name    = var.tunnel_name
  type    = "CNAME"
  content = format("%s.cfargotunnel.com", cloudflare_zero_trust_tunnel_cloudflared.this.id)
  ttl     = 1
  proxied = true
}