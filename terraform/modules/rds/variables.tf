variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Subnets where the RDS instance can be allocated"
}

variable "rds_sg_id" {
  type        = string
  description = "Security Group ID allowing access to the database"
}

variable "db_username" {
  type        = string
  description = "Database master username"
  default     = "postgres"
}

variable "db_password" {
  type        = string
  description = "Database master password"
  sensitive   = true # Marks password as sensitive to hide it from logs
}
