resource "aws_iam_role" "eks-nodes-role" {
  name = "${var.cluster_name}-nodes-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-nodes-role.name
}

resource "aws_iam_role_policy_attachment" "eks-nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-nodes-role.name
}

resource "aws_iam_role_policy_attachment" "eks-nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-nodes-role.name
}

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  version         = var.cluster_version
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.eks-nodes-role.arn
  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]

  capacity_type  = "SPOT"
  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "private-nodes"
  }

  depends_on = [
    module.vpc,
    aws_eks_cluster.eks-cluster,
    aws_iam_role_policy_attachment.eks-nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-nodes-AmazonEC2ContainerRegistryReadOnly
  ]

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}