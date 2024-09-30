resource "kubernetes_horizontal_pod_autoscaler" "diet-hpa" {
  metadata {
    name = "diet-hpa"
    namespace = "default"
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "diet-deploy"
    }

    min_replicas = 1
    max_replicas = 3

    target_cpu_utilization_percentage = 50
  }
}