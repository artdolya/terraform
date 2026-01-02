data "cloudflare_zero_trust_tunnel_cloudflared_token" "this" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id
}

resource "kubernetes_secret" "cloudflared_token" {
  metadata {
    name      = format("%s-tunnel-token", var.tunnel_name)
    namespace = var.namespace
  }

  data = {
    TUNNEL_TOKEN = data.cloudflare_zero_trust_tunnel_cloudflared_token.this.token
  }

  type = "Opaque"
}

resource "kubernetes_deployment" "cloudflared" {
  metadata {
    name      = format("%s-cloudflared", var.tunnel_name)
    namespace = var.namespace
    labels    = { app = "cloudflared" }
  }

  spec {
    replicas = 2

    selector {
      match_labels = { app = "cloudflared" }
    }

    template {
      metadata {
        labels = { app = "cloudflared" }
      }

      spec {
        container {
          name  = "cloudflared"
          image = "cloudflare/cloudflared:latest"

          # Force http2 to avoid QUIC/UDP 7844 instability (your exact issue).
          # Cloudflare supports multiple protocols for published apps. :contentReference[oaicite:4]{index=4}
          args = [
            "tunnel",
            "--no-autoupdate",
            "--protocol", "http2",
            "run",
            "--token", "$(TUNNEL_TOKEN)"
          ]

          env {
            name = "TUNNEL_TOKEN"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.cloudflared_token.metadata[0].name
                key  = "TUNNEL_TOKEN"
              }
            }
          }

          # Optional: metrics
          port {
            name           = "metrics"
            container_port = 20241
          }

          liveness_probe {
            http_get {
              path = "/metrics"
              port = "metrics"
            }
            initial_delay_seconds = 10
            period_seconds        = 20
          }
        }
      }
    }
  }

  depends_on = [
    cloudflare_zero_trust_tunnel_cloudflared_config.this,
    kubernetes_secret.cloudflared_token
  ]
}
