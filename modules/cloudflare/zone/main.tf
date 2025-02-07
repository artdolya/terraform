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

