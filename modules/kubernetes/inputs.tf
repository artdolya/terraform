variable "env_vars" {
  type        = string
  description = "Environment variables to be set in the pod, in the format VAR1=VALUE1\nVAR2=VALUE2"
  default     = ""
}

variable "namespace" {
  type        = string
  description = "The namespace in which to create the resources"
}

variable "name" {
  type        = string
  description = "The name of the pod"
}

variable "image" {
  type        = string
  description = "The image to use for the pod"
}

variable "port" {
  type        = number
  description = "The port to expose on the container"
}

variable "target_port" {
  type        = number
  description = "The target port to expose on the container"
}

variable "node_port" {
  type        = number
  description = "The node port to expose on the service"
}

variable "cluster_domain" {
  type    = string
  default = "cluster.local"
}
