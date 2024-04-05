
# AWS Provider Configuration

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
 
}


resource "aws_s3_bucket" "rentzone-app" {
    bucket = "rentzone-app-remote-state"
      force_destroy = true
    lifecycle {
      prevent_destroy = false
    }

    tags = {
        Name = "rentzone_app bucket"
        
    }

   
}

# terraform {
#   backend "s3" {
#     bucket = "[rentzone_app]--[us-east-1a]--x-s3"
#     key = "rentzone-app/terraform.tfstate"
#     region = "us-east-1"
#     dynamodb_table = "terraform-state-lock"
#     profile = "default"

#   }
# }
