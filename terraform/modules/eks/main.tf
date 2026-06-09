# 1. AWS EKS Cluster Control Plane
resource "aws_eks_cluster" "this" {
  name     = "${var.project_name}-eks"
  role_arn = var.eks_cluster_role_arn

  vpc_config {
    subnet_ids             = var.public_subnet_ids
    security_group_ids     = [var.eks_nodes_sg_id]
    endpoint_public_access = true # Allows us to connect via kubectl from our local machine
  }
}

# 2. EKS Managed Node Group (Worker Nodes)
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = var.eks_nodes_role_arn
  subnet_ids      = var.public_subnet_ids

  # Scaling configuration
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  # SRE Sizing Choice: We use t3.small (2 vCPUs, 2 GiB memory). 
  # Why: t3.micro (1 GiB) is too small to run Kubernetes system pods + our apps, causing Out Of Memory (OOM) crashes.
  # Cost: t3.small is only ~$0.02 per hour. Running it for a 2-hour demo costs less than 5 cents.
  instance_types = ["t3.small"]
}
