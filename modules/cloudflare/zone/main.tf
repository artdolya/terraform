resource "cloudflare_zone" "this" {
  name = var.domain_name
  account = {
    id = var.account_id
  }
}

resource "cloudflare_dns_record" "dns_records" {
  for_each = { for record in flatten([
    for type, record_map in var.records : [
      for name, values in record_map : [
        for idx, value in values : {
          id      = "${type}-${name}-${idx}"
          name    = name
          type    = type
          content = value
        }
      ]
    ]
    ]) : record.id => record
  }

  zone_id = cloudflare_zone.this.id
  name    = each.value.name
  type    = each.value.type
  content = each.value.content
  ttl     = 1
}

resource "cloudflare_dns_record" "proxied_dns_records" {
  for_each = { for record in flatten([
    for type, record_map in var.proxied_records : [
      for name, values in record_map : [
        for idx, value in values : {
          id      = "${type}-${name}-${idx}"
          name    = name
          type    = type
          content = value
        }
      ]
    ]
    ]) : record.id => record
  }

  zone_id = cloudflare_zone.this.id
  name    = each.value.name
  type    = each.value.type
  content = each.value.content
  proxied = true
  ttl     = 1
}

resource "cloudflare_zone_setting" "zone_tls" {
  zone_id    = cloudflare_zone.this.id
  setting_id = "tls_1_3"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_ssl" {
  zone_id    = cloudflare_zone.this.id
  setting_id = "ssl"
  value      = var.ssl_mode
}

resource "cloudflare_zone_setting" "zone_https" {
  zone_id    = cloudflare_zone.this.id
  setting_id = "automatic_https_rewrites"
  value      = "on"
}
