output "internal_link" {
  value = "http://${kubernetes_service.this.metadata[0].name}.${kubernetes_service.this.metadata[0].namespace}.svc.${var.cluster_domain}:${kubernetes_service.this.spec[0].port[0].target_port}"
}
