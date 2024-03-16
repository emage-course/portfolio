
data "hcp_vault_secrets_app" "techsecom-infra" {
  app_name = "techsecom-infra"
}
data "cloudflare_zones" "domain" {
  filter {
    name   = var.domain_name
    status = "active"
  }
}

# data "cloudflare_accounts" "" {
#   name = "af49a211cd96ecd23f252eed8bd2fcfa"
# }