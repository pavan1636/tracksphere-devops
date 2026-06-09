# 1. Database Subnet Group
# Grouping the subnets so RDS knows which availability zones to use
resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.public_subnet_ids

  tags = {
    Name        = "${var.project_name}-db-subnet-group"
    Environment = var.environment
  }
}

# 2. RDS PostgreSQL Instance
resource "aws_db_instance" "this" {
  identifier           = "${var.project_name}-db"
  allocated_storage     = 20               # 20 GB is covered by the AWS Free Tier
  max_allocated_storage = 100              # Allows storage to autoscale if needed
  db_subnet_group_name  = aws_db_subnet_group.this.name
  engine                = "postgres"
  engine_version        = "15.18"          # Stable, standard PostgreSQL version
  instance_class        = "db.t3.micro"    # 100% Free Tier instance size
  db_name               = var.project_name
  username              = var.db_username
  password              = var.db_password
  vpc_security_group_ids = [var.rds_sg_id]  # Locked down to EKS node traffic only
  publicly_accessible   = false            # SRE Best Practice: Hide database from internet

  # Clean Up Rule
  skip_final_snapshot = true # Allows database to delete instantly when running destroy (saves cost)

  tags = {
    Name        = "${var.project_name}-db"
    Environment = var.environment
  }
}
