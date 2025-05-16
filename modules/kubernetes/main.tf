locals {
  svc_name = "${var.name}-svc"
  env_vars = [
    for line in split("\n", var.env_vars) :
    {
      name  = split("=", line)[0]
      value = join("=", slice(split("=", line), 1, length(split("=", line))))
    }
    if length(trimspace(line)) > 0 && can(split("=", line)[1])
  ]
  labels = {
    app = var.name
  }
}

# Pod defines the image
resource "kubernetes_pod" "this" {
  metadata {
    name      = local.svc_name
    namespace = var.namespace
    labels    = local.labels
  }

  spec {
    container {
      name  = var.name
      image = var.image # <--- IMAGE is here

      port {
        container_port = var.port
      }
    }
  }
}

resource "kubernetes_service" "this" {
  metadata {
    name      = local.svc_name
    namespace = var.namespace
  }

  spec {
    selector = local.labels

    port {
      name        = "http"
      port        = var.port
      target_port = var.target_port
      node_port   = var.node_port
    }

    type = "NodePort"

  }
}
