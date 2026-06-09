variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs where nodes will run"
}

variable "eks_cluster_role_arn" {
  type        = string
  description = "IAM Role ARN for EKS Cluster"
}

variable "eks_nodes_role_arn" {
  type        = string
  description = "IAM Role ARN for EKS Nodes"
}

variable "eks_nodes_sg_id" {
  type        = string
  description = "Security Group ID for EKS nodes"
}
