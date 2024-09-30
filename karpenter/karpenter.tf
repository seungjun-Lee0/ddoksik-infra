resource "kubectl_manifest" "karpenter_provisioner" {
  yaml_body = <<-YAML
  apiVersion: karpenter.sh/v1alpha5
  kind: Provisioner
  metadata:
    name: prod-provisioner
  spec:
    ttlSecondsAfterEmpty: 60
    ttlSecondsUntilExpired: 604800
    limits:
      resources:
        cpu: 100 # limit to 100 CPU cores
    requirements:
      - key: karpenter.k8s.aws/instance-family
        operator: In
        values: [t3]
      - key: karpenter.k8s.aws/instance-size
        operator: In
        values: [small]
    provider:
      subnetSelector:
        karpenter.sh/discovery: ${var.cluster_name}
      securityGroupSelector:
        karpenter.sh/discovery: ${var.cluster_name}
      tags:
        karpenter.sh/discovery: ${var.cluster_name}
  YAML
}
# resource "kubectl_manifest" "karpenter_provisioner" {
#   yaml_body = <<-YAML
#   apiVersion: karpenter.sh/v1alpha5
#   kind: Provisioner
#   metadata:
#     name: default
#   spec:
#     requirements:
#       - key: karpenter.sh/capacity-type
#         operator: In
#         values: ["on-demand"]
#       - key: "node.kubernetes.io/instance-type"
#         operator: In
#         values: [ "t3.medium" ]        
#     limits:
#       resources:
#         cpu: 1000
#     provider:
#       subnetSelector:
#         karpenter.sh/discovery: ${var.cluster_name}
#       securityGroupSelector:
#         karpenter.sh/discovery: ${var.cluster_name}
#       tags:
#         karpenter.sh/discovery: ${var.cluster_name}
#     ttlSecondsAfterEmpty: 30
#   YAML

#   depends_on = [
#     helm_release.karpenter
#   ]
# }
