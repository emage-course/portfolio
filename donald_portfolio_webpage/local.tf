locals {
  mime_types = {

    "html"  = "text/html",
    "webp"  = "image/webp",
    "js"    = "application/javascript",
    "ico"   = "image/vnd.microsoft.icon",
    "ttf"   = "font/ttf",
    "woff2" = "font/woff2",
    "woff"  = "font/woff",
    "gif"   = "image/gif",
    "eot"   = "application/vnd.ms-fontobject"
    "css"   = "text/css"
    "jpeg"  = "image/jpeg"
    "jpg"   = "image/jpeg"
    "png"   = "image/png"
    "svg"   = "image/svg+xml"
    "txt"   = "text/plain"
  }
  cname_value = try(module.webpage_portfolio_v1.s3_bucket_website_endpoint, "")
}
