terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.30"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.19"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.79"
    }
  }
  backend "s3" {
    bucket         = "techsecom-rke2-manager-state"
    key            = "solomon-portfolio-webpage.tfstate"
    region         = "us-east-2"
    dynamodb_table = "techsecom-rke2-manager-state" # Optional, remove this line if you don't want to use locking
    # encrypt        = true
  }
}