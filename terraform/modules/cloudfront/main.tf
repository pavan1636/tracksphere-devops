# 1. CloudFront Origin Access Control (OAC)
# This securely signs requests from CloudFront to your private S3 bucket
resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "${var.project_name}-oac"
  description                       = "OAC for private S3 bucket static hosting"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# 2. CloudFront CDN Distribution
resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  default_root_object = "index.html" # Serves index.html when users hit the base URL

  # Connects the CDN to your private S3 bucket
  origin {
    domain_name              = var.s3_bucket_domain_name
    origin_id                = var.s3_bucket_id
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  # Default Cache Settings (caching React static assets at Edge locations)
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.s3_bucket_id
    viewer_protocol_policy = "allow-all" # Allows HTTP access so we can talk to the HTTP EKS load balancer

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  # Viewer Certificates (using default CloudFront SSL certificates)
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  # Geolocation restrictions (not restricting any countries for demo purposes)
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "${var.project_name}-cloudfront"
    Environment = var.environment
  }
}

# 3. S3 Bucket Policy for CloudFront
# This policy grants the CloudFront distribution permission to read objects from S3
resource "aws_s3_bucket_policy" "cloudfront_read" {
  bucket = var.s3_bucket_id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "AllowCloudFrontServicePrincipalReadOnly"
        Effect   = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${var.s3_bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.this.arn
          }
        }
      }
    ]
  })
}
