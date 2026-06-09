output "eks_cluster_role_arn" {
  value       = aws_iam_role.eks_cluster.arn
  description = "ARN of the IAM role for the EKS Cluster control plane"
}

output "eks_nodes_role_arn" {
  value       = aws_iam_role.eks_nodes.arn
  description = "ARN of the IAM role for the EKS Worker Nodes"
}
