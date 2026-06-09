# 1. VPC Network Module
module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  environment  = var.environment
}

# 2. IAM Roles & Policies Module
module "iam" {
  source = "./modules/iam"
}

# 3. Security Groups (Firewalls) Module
module "security_groups" {
  source       = "./modules/security_groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}

# 4. EKS Cluster Module
module "eks" {
  source               = "./modules/eks"
  project_name         = var.project_name
  environment          = var.environment
  public_subnet_ids    = module.vpc.public_subnet_ids
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_nodes_role_arn   = module.iam.eks_nodes_role_arn
  eks_nodes_sg_id      = module.security_groups.eks_nodes_sg_id
}

# 5. RDS PostgreSQL Database Module
module "rds" {
  source            = "./modules/rds"
  project_name      = var.project_name
  environment       = var.environment
  public_subnet_ids = module.vpc.public_subnet_ids
  rds_sg_id         = module.security_groups.rds_sg_id
  db_username       = var.db_username
  db_password       = var.db_password
}

# 6. S3 Bucket Storage Module
module "s3" {
  source       = "./modules/s3"
  project_name = var.project_name
  environment  = var.environment
}

# 7. CloudFront CDN Module
module "cloudfront" {
  source                = "./modules/cloudfront"
  project_name          = var.project_name
  environment           = var.environment
  s3_bucket_id          = module.s3.bucket_id
  s3_bucket_arn         = module.s3.bucket_arn
  s3_bucket_domain_name = module.s3.bucket_domain_name
}
