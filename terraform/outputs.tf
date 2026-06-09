output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the custom VPC"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "List of public subnet IDs"
}

output "eks_cluster_name" {
  value       = module.eks.cluster_name
  description = "The name of the EKS cluster"
}

output "eks_cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint for the EKS cluster API server"
}

output "rds_endpoint" {
  value       = module.rds.db_endpoint
  description = "The connection endpoint for the RDS database"
}

output "cloudfront_url" {
  value       = module.cloudfront.cloudfront_domain_name
  description = "The public URL of the CloudFront distribution hosting the frontend"
}
