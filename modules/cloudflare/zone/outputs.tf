output "zone" {
  value = {
    id          = cloudflare_zone.this.id
    nameservers = cloudflare_zone.this.name_servers
  }
}

output "records" {
  value = {
    mx = {
      "mx_73" = length(cloudflare_record.mx_73) > 0 ? cloudflare_record.mx_73[0].value : null
      "mx_58" = length(cloudflare_record.mx_58) > 0 ? cloudflare_record.mx_58[0].value : null
      "mx_59" = length(cloudflare_record.mx_59) > 0 ? cloudflare_record.mx_59[0].value : null
    }
    txt = {
      "all" = length(cloudflare_record.txt_all) > 0 ? cloudflare_record.txt_all[0].value : null
    }
  }
}

output "email" {
  value = {
    settings = {
      enabled = cloudflare_email_routing_settings.this.enabled
      name    = cloudflare_email_routing_settings.this.name
    }
    default_email = var.email.catch_all
    forwardings   = { for k, v in cloudflare_email_routing_rule.forwarding : "${k}@${var.domain_name}" => element(v.action[*].value, 0) }
  }
}

output "dns_records" {
  value = local.flattened_dns_records
}
