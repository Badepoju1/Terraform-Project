
# AWS Provider Configuration

provider "aws" {
  region     = var.region
  profile = "bade"
 
}


resource "aws_s3_bucket" "rentzone-app" {
    bucket = "app-rentzone"
        
      force_destroy = true
    lifecycle {
      prevent_destroy = false
    }

    tags = {
        Name = "rentzone_app bucket"
        
    }

   
}

resource "aws_s3_bucket_public_access_block" "bade_bucket_access" {
  bucket = aws_s3_bucket.rentzone-app.id

  block_public_acls   = true
  block_public_policy = true
 }

output "s3_bucket" {
  value = [aws_s3_bucket.rentzone-app.arn]
}