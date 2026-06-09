# 1. Create S3 Bucket
resource "aws_s3_bucket" "this" {
  bucket        = "${var.project_name}-frontend-assets-pavan"
  force_destroy = true # Allows Terraform to empty and delete the bucket if we run destroy

  tags = {
    Name        = "${var.project_name}-frontend-assets"
    Environment = var.environment
  }
}

# 2. Block all Public Access
# This keeps the bucket private and secure
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 3. Enable Versioning
# Saves historical copies of files so we can recover from accidental deletions
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}
