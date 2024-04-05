# # AWS EIP Configuration

resource "aws_eip" "nat-eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}


# # AWS NAT Gateway Configuration

resource "aws_nat_gateway" "nat-private-app" {
  
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = slice(aws_subnet.private-app-subnetAZ.*.id, 0, 1)
  depends_on = [ aws_internet_gateway.public-igw ]

  tags = {
    Name = "nat-private-app"
  }
}

resource "aws_nat_gateway" "nat-private-data" {
  
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = slice(aws_subnet.private-data-subnetAZ.*.id, 0, 1)
  depends_on = [ aws_internet_gateway.public-igw ]

  tags = {
    Name = "nat-private-data"
  }
}

# # AWS  Gateway Configuration

resource "aws_internet_gateway" "public-igw" {
 count = var.vpc-id
  vpc_id = var.vpc-id
  
  tags = {
    Name = "public-igw"
  }

}
