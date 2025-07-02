variable "env_vars" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "Environment variables to be set in the pod, in the form of key=value"
  default     = []
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
  default     = null
}

variable "cluster_domain" {
  type    = string
  default = "cluster.local"
}

variable "replica_count" {
  type        = number
  description = "The number of replicas to create"
  default     = 1
}

