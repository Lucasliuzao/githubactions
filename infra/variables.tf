# infra/variables.tf

variable "aws_region" {
  description = "A região da AWS onde os recursos serão criados."
  type        = string
  default     = "us-east-1"
}

variable "admin_password" {
  description = "A senha para o usuário administrador da instância EC2."
  type        = string
  sensitive   = true # Marca a variável como sensível para não exibi-la nos logs.
}