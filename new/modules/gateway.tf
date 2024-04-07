# # AWS EIP Configuration

resource "aws_eip" "nat-eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}


# # AWS NAT Gateway Configuration

resource "aws_nat_gateway" "nat-gw" {
  
  allocation_id = aws_eip.nat-eip.id
  count = length(var.availability_zones)
  subnet_id     = slice(aws_subnet.public-subnetAZ.*.id, 0, 1)
  depends_on = [ aws_internet_gateway.public-igw ]

  tags = {
    Name = "nat-gw${count.index + 1}"
  }
}

