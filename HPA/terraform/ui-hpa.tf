resource "kubernetes_horizontal_pod_autoscaler" "ui-hpa" {
  metadata {
    name = "ui-hpa"
    namespace = "default"
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "ui-deploy"
    }

    min_replicas = 1
    max_replicas = 3

    target_cpu_utilization_percentage = 50
  }
}