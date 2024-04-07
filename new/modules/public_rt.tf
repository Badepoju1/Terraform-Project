#  Private App RT Configuration

resource "aws_route_table" "public-rt" {
    vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public-igw.id
  }

  tags = {
    Name = "private-data-rt"
  }

}

# Private App RT Table Association with the two Public Subnet

resource "aws_route_table_association" "public-rta" {
  count = length(var.public_subnets)
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = element([aws_subnet.public-subnetAZ.*.id], count.index)
}
