variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "account_id" {
  description = "Cloudflare account ID"
  type        = string
}

variable "email" {
  type = object({
    catch_all   = string
    forwardings = optional(map(string), {})
  })
  default = {
    catch_all   = ""
    forwardings = {}
  }
}

variable "records" {
  description = "DNS records to be created"
  type        = map(map(list(string)))
  default     = {}
}