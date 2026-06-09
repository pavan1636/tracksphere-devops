output "db_endpoint" {
  value       = aws_db_instance.this.endpoint
  description = "The database connection host endpoint (host:port)"
}

output "db_username" {
  value       = aws_db_instance.this.username
  description = "The database master username"
}
