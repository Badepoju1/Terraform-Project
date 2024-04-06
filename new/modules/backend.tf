
# AWS Provider Configuration

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
 
}


resource "aws_s3_bucket" "rentzone-app" {
    bucket = "rentzone-app"
        
      force_destroy = true
    lifecycle {
      prevent_destroy = false
    }

    tags = {
        Name = "rentzone_app bucket"
        
    }

   
}

resource "aws_s3_bucket_public_access_block" "some_bucket_access" {
  bucket = aws_s3_bucket.rentzone-app.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
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
