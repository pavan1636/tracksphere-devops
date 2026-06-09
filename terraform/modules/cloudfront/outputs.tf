output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.this.domain_name
  description = "The public URL of the CloudFront distribution hosting the frontend"
}
