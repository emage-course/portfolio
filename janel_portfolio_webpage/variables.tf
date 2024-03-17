variable "domain_name" {
  type        = string
  description = "The domain name for the Cloudflare zone"
  default     = "techsecom.co"
}

variable "subdomain_name" {
  type        = string
  description = "The subdomain to create in the Cloudflare zone"
  default     = "solomon"
}


variable "hcp_client_id" {
  type        = string
  description = "vault-secret client id"
  default     = ""
}

variable "hcp_client_secret" {
  type        = string
  description = "vault client secret id"
  default     = ""
}

variable "acl" {
  description = "(Optional) The canned ACL to apply. Conflicts with `grant`"
  type        = string
  default     = null
}
