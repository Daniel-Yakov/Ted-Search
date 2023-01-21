output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "give VPC details"
}

output "subnet_id" {
  value       = aws_subnet.sub.id
  description = "subnet's id"
}