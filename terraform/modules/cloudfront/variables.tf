variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "s3_bucket_id" {
  type        = string
  description = "The ID of the S3 bucket origin"
}

variable "s3_bucket_arn" {
  type        = string
  description = "The ARN of the S3 bucket origin"
}

variable "s3_bucket_domain_name" {
  type        = string
  description = "The domain name of the S3 bucket"
}
