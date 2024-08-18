
data "hcp_vault_secrets_app" "solyspace-infra" {
  app_name = "solyspace-infra"
}
data "cloudflare_zones" "domain" {
  filter {
    name   = var.domain_name
    status = "active"
  }
}