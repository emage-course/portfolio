
data "hcp_vault_secrets_app" "techsecom-infra" {
  app_name = "kendopx-infra"
}
data "cloudflare_zones" "domain" {
  filter {
    name   = var.domain_name
    status = "active"
  }
}