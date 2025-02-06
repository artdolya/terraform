resource "cloudflare_record" "mx_73" {
  count    = var.email != null ? 1 : 0
  zone_id  = cloudflare_zone.this.id
  type     = "MX"
  name     = var.domain_name
  content  = "route1.mx.cloudflare.net"
  priority = 73
  proxied  = false
}

resource "cloudflare_record" "mx_58" {
  count    = var.email != null ? 1 : 0
  zone_id  = cloudflare_zone.this.id
  type     = "MX"
  name     = var.domain_name
  content  = "route2.mx.cloudflare.net"
  priority = 58
  proxied  = false
}

resource "cloudflare_record" "mx_59" {
  count    = var.email != null ? 1 : 0
  zone_id  = cloudflare_zone.this.id
  type     = "MX"
  name     = var.domain_name
  content  = "route3.mx.cloudflare.net"
  priority = 59
  proxied  = false
}


resource "cloudflare_record" "txt_all" {
  count   = var.email != null ? 1 : 0
  zone_id = cloudflare_zone.this.id
  type    = "TXT"
  name    = var.domain_name
  content = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  proxied = false
}

resource "cloudflare_email_routing_catch_all" "this" {
  count   = var.email.catch_all != "" ? 1 : 0
  zone_id = cloudflare_zone.this.id
  name    = "catch all"
  enabled = true

  matcher {
    type = "all"
  }

  action {
    type  = "forward"
    value = [var.email.catch_all]
  }
}

resource "cloudflare_email_routing_rule" "forwarding" {
  for_each = var.email.forwardings
  zone_id  = cloudflare_zone.this.id
  name     = "terraform routing rule"
  enabled  = true

  matcher {
    type  = "literal"
    field = "to"
    value = "${each.key}@${var.domain_name}"
  }

  action {
    type  = "forward"
    value = [each.value]
  }
}
