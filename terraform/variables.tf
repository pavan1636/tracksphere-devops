variable "aws_region" {
  type        = string
  description = "AWS region for deployment"
  default     = "eu-west-1"
}

variable "project_name" {
  type        = string
  description = "Project name tag prefix"
  default     = "tracksphere"
}

variable "environment" {
  type        = string
  description = "Deployment environment name"
  default     = "production"
}

variable "db_username" {
  type        = string
  description = "Database master username"
  default     = "postgres"
}

variable "db_password" {
  type        = string
  description = "Database master password. This will be prompted on terraform apply."
  sensitive   = true
}
