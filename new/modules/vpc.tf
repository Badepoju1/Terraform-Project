
# # AWS VPC Configuration

resource "aws_vpc" "badevpc" {
 cidr_block = var.vpc_cidr_block
 
  tags = {
    Name = "badevpc"
  }
}
