terraform {
  backend "s3" {
    # Substitua pelo nome do seu bucket S3
    bucket         = "githubactions-lucassilva"
    # O caminho e nome do arquivo de estado dentro do bucket
    key            = "global/terraform.tfstate"
    # A região do seu bucket S3
    region         = "us-east-1"
    # Substitua pelo nome da sua tabela DynamoDB
    dynamodb_table = "githubactions-state-lock"
  }
}