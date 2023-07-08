variable "bucket_name" {
  type        = string
  description = "The domain name to use for the static site"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "public_access" {
  type    = bool
  default = false
}
