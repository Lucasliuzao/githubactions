# infra/outputs.tf

output "instance_public_ip" {
  description = "O endereço de IP público da instância EC2 criada."
  value       = aws_instance.web_server.public_ip
}

output "instance_id" {
  description = "O ID da instância EC2 criada."
  value       = aws_instance.web_server.id
}