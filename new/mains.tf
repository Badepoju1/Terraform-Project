module "main-config" {
    source = "./modules"
    vpc-id = var.vpc-id
    public_subnets = var.public_subnets
    privateapp_subnets = var.privateapp_subnets
    privatedata_subnets = var.privatedata_subnets
    dbsubnet-name = var.dbsubnet-name
    db-name = var.db-name
    db_engine = var.db-name
    db_instance_type = var.db_instance_type
    db_pass = var.db_pass
    db_username = var.db_username
    nat-gw = var.nat-gw
    access_key = var.access_key
    secret_key = var.access_key
    vpc_cidr_block = var.vpc_cidr_block
    region = var.region
    launch_template_name = var.launch_template_name
    availability_zones = var.availability_zones
    ec2_image_id = var.ec2_image_id
    ec2_instance_type = var.ec2_instance_type
    subnet_cidr_blocks = var.subnet_cidr_blocks

}

resource "aws_s3_bucket_object" "reantzone_object" {
  bucket = aws_s3_bucket.rentzone-app.arn
  key    = "rentzone.zip"
  source = "/Terraform-Project/new/rentzone.zip"
}