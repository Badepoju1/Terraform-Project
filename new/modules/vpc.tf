
# # AWS VPC Configuration

resource "aws_vpc" "badevpc" {
 cidr_block = var.vpc_cidr_block
 
  tags = {
    Name = "badevpc"
  }
}

# # AWS  Gateway Configuration

resource "aws_internet_gateway" "public-igw" {
   vpc_id = var.vpc-id
  
  tags = {
    Name = "public-igw"
  }

}