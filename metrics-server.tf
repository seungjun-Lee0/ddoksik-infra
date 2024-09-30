resource "helm_release" "metrics_server" {
  name             = "metrics-server"
  version          = "3.12.0"
  repository       = "https://kubernetes-sigs.github.io/metrics-server/"
  chart            = "metrics-server"
  namespace        = "kube-system"
}
