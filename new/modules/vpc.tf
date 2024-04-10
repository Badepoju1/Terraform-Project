
# # AWS VPC Configuration

resource "aws_vpc" "badevpc" {
 cidr_block = var.vpc_cidr_block
 
  tags = {
    Name = "badevpc"
  }
}

# # AWS  Gateway Configuration

resource "aws_internet_gateway" "public-igw" {
   vpc_id = aws_vpc.badevpc.id
  
  tags = {
    Name = "public-igw"
  }

}

output "vpc-id" {
    value = [aws_vpc.badevpc.id]
}