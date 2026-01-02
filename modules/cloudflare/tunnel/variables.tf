variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "cloudflare_account_id" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}

variable "namespace" {
  type    = string
}

variable "tunnel_name" {
  type    = string
}

variable "hostname" {
  type    = string
}

variable "origin_service" {
  type    = string
}