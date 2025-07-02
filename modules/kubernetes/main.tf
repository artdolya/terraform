locals {
  svc_name = "${var.name}-svc"

  labels = {
    app = var.name
  }
}

# Pod defines the image
resource "kubernetes_deployment" "this" {
  metadata {
    name      = local.svc_name
    namespace = var.namespace
    labels    = local.labels
  }

  spec {
    replicas = var.replica_count

    selector {
      match_labels = local.labels
    }

    template {
      metadata {
        labels = local.labels
      }

      spec {
        container {
          name  = var.name
          image = var.image

          port {
            container_port = var.port
          }

          dynamic "env" {
            for_each = var.env_vars
            content {
              name  = env.value.name
              value = env.value.value
            }
          }
        }
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
