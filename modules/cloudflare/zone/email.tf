resource "cloudflare_dns_record" "mx_1" {
  count    = var.email.create_mx_records ? 1 : 0
  zone_id  = cloudflare_zone.this.id
  type     = "MX"
  name     = var.domain_name
  content  = "route1.mx.cloudflare.net"
  priority = 30
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "mx_2" {
  count    = var.email.create_mx_records ? 1 : 0
  zone_id  = cloudflare_zone.this.id
  type     = "MX"
  name     = var.domain_name
  content  = "route2.mx.cloudflare.net"
  priority = 50
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "mx_3" {
  count    = var.email.create_mx_records ? 1 : 0
  zone_id  = cloudflare_zone.this.id
  type     = "MX"
  name     = var.domain_name
  content  = "route3.mx.cloudflare.net"
  priority = 70
  proxied  = false
  ttl      = 1
}


resource "cloudflare_dns_record" "txt_all" {
  zone_id = cloudflare_zone.this.id
  type    = "TXT"
  name    = var.domain_name
  content = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  proxied = false
  ttl     = 1
}

resource "cloudflare_email_routing_catch_all" "this" {
  count   = var.email.catch_all != "" ? 1 : 0
  zone_id = cloudflare_zone.this.id
  name    = "catch all"
  enabled = true

  matchers = [{
    type = "all"
  }]

  actions = [{
    type  = "forward"
    value = [var.email.catch_all]
  }]
}

resource "cloudflare_email_routing_rule" "forwarding" {
  for_each = var.email.forwardings
  zone_id  = cloudflare_zone.this.id
  name     = "terraform routing rule"
  enabled  = true

  matchers = [{
    type  = "literal"
    field = "to"
    value = "${each.key}@${var.domain_name}"
  }]

  actions = [{
    type  = "forward"
    value = [each.value]
  }]
}
