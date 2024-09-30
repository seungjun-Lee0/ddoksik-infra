resource "aws_iam_role_policy_attachment" "ebs-csi" {
  role       = module.eks.eks_managed_node_groups["initial"].iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_eks_addon" "ebs-csi" {
  cluster_name  = var.cluster_name
  addon_name    = "aws-ebs-csi-driver"
  addon_version = "v1.26.1-eksbuild.1"

  depends_on = [module.eks]
}

