provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}

provider "cloudflare" {
  email   = data.hcp_vault_secrets_app.techsecom-infra.secrets["cloudflare_email"]
  api_key = data.hcp_vault_secrets_app.techsecom-infra.secrets["cloudflare_api_key"]
}

provider "aws" {
  region     = "us-east-2"
  access_key = data.hcp_vault_secrets_app.techsecom-infra.secrets["aws_admin_access_key"]
  secret_key = data.hcp_vault_secrets_app.techsecom-infra.secrets["aws_admin_secret_key"]

}