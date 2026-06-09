output "eks_nodes_sg_id" {
  value       = aws_security_group.eks_nodes.id
  description = "The ID of the EKS worker nodes security group"
}

output "rds_sg_id" {
  value       = aws_security_group.rds.id
  description = "The ID of the RDS database security group"
}
