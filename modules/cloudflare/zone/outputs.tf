output "zone" {
  value = {
    id          = cloudflare_zone.this.id
    nameservers = cloudflare_zone.this.name_servers
  }
}

output "records" {
  value = {
    mx = {
      "mx_1" = cloudflare_dns_record.mx_1
      "mx_2" = cloudflare_dns_record.mx_2
      "mx_3" = cloudflare_dns_record.mx_3
    }
    txt = {
      "all" = cloudflare_dns_record.txt_all
    }
  }
}
