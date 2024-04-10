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
  count = length(var.nat-gw)
  subnet_id     = aws_subnet.private-app-subnetAZ[count.index].id
  depends_on = [ aws_internet_gateway.public-igw ]

  tags = {
    Name = "nat-gw${count.index + 1}"
  }
}

output "nat-gw" {
    value = aws_nat_gateway.nat-gw[*].public_ip
  
}
