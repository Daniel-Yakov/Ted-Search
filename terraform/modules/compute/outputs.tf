output "instance_id" {
  value       = aws_instance.app.id
  description = "instance id"
}

output "public_ip" {
  value       = aws_instance.app.public_ip
  description = "public ip"
}

output "key" {
  value       = tls_private_key.gen_ssh_key.private_key_pem
  description = "description"
}
