variable "source_dir" {
  type        = string
  description = "Folder containg web site"
}

variable "bucket_name" {
  type        = string
  description = "The domain name to use for the static site"
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "default_index_page" {
  type        = string
  description = "Default page: index.html"
  default     = "index.html"
}

variable "default_error_page" {
  type        = string
  description = "Default page: error.html"
  default     = "error.html"
}