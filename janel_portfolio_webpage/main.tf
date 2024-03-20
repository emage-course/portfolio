

data "aws_caller_identity" "current" {}

module "webpage_portfolio_v1" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.1"

  bucket = format("%s.%s", var.subdomain_name, data.cloudflare_zones.domain.zones[0].name)

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  expected_bucket_owner    = data.aws_caller_identity.current.account_id
  acl                      = "public-read"

  attach_policy = true
  policy        = file("./bucket_policy.json")
  website = {
    index_document = "coming-soon.html"
    error_document = "error-404.html"
    routing_rules = [{
      condition = {
        key_prefix_equals = "docs/"
      },
      redirect = {
        replace_key_prefix_with = "documents/"
      }
      }, {
      condition = {
        http_error_code_returned_equals = 404
        key_prefix_equals               = "archive/"
      },
      redirect = {
        host_name          = "www.janel.kendopx.com"
        http_redirect_code = 301
        protocol           = "https"
        replace_key_with   = "error-404.html"
      }
    }]
  }
  cors_rule = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["GET"]
      allowed_origins = ["https://janel.kendopx.com"]
      max_age_seconds = 3000
    }
  ]
}

resource "aws_s3_object" "s3_objects" {
  for_each = fileset("${path.module}/website", "**/*")

  bucket       = module.webpage_portfolio_v1.s3_bucket_id
  key          = each.key
  source       = "${path.module}/website/${each.key}"
  content_type = lookup(local.mime_types, element(split(".", each.key), length(split(".", each.key)) - 1), "binary/octet-stream")
  depends_on   = [module.webpage_portfolio_v1]
  etag         = filemd5("${path.module}/website/${each.key}")
}


resource "cloudflare_record" "my_domain" {
  # allow_overwrite = false
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = format("%s.%s", var.subdomain_name, data.cloudflare_zones.domain.zones[0].name)
  type    = "CNAME"
  value   = local.cname_value
  proxied = true

  depends_on = [module.webpage_portfolio_v1]
}

# Create a Cloudflare page rule to enforce HTTPS redirection
resource "cloudflare_page_rule" "http_to_https" {
  zone_id  = data.cloudflare_zones.domain.zones[0].id
  target   = "${format("%s.%s", var.subdomain_name, data.cloudflare_zones.domain.zones[0].name)}/*"
  priority = 1
  status   = "active"
  actions {
    always_use_https = true
  }
  depends_on = [cloudflare_record.my_domain]
}

# Override SSL configuration type
resource "cloudflare_zone_settings_override" "my_zone_settings" {
  zone_id = data.cloudflare_zones.domain.zones[0].id

  settings {
    ssl = "flexible"
  }
  depends_on = [cloudflare_page_rule.http_to_https]
}

resource "cloudflare_worker_script" "janel_html_extension" {
  name       = "janel-html-extension"
  content    = file("${path.module}/janel_html_extension.js")
  account_id = "9839072740566e6053a85a40082affff"
}

resource "cloudflare_worker_route" "janel_html_extension_route" {
  zone_id     = data.cloudflare_zones.domain.zones[0].id
  pattern     = format("%s.%s/*", var.subdomain_name, data.cloudflare_zones.domain.zones[0].name)
  script_name = cloudflare_worker_script.janel_html_extension.name
  depends_on  = [cloudflare_record.my_domain]
}