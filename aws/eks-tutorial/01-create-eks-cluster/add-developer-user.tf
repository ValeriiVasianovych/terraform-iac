resource "aws_iam_user" "developer" {
  name = "developer"
}

resource "aws_iam_policy" "developer_eks" {
  name = "developer-eks"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" = [
          "eks:DescribeCluster",
          "eks:ListClusters"
        ],
        "Resource" = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "developer_eks" {
  user       = aws_iam_user.developer.name
  policy_arn = aws_iam_policy.developer_eks.arn
}

resource "aws_eks_access_entry" "developer" {
  cluster_name      = var.cluster_name
  principal_arn     = aws_iam_user.developer.arn
  kubernetes_groups = ["viewer-group"]
}