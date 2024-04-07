#  Private App RT Configuration

resource "aws_route_table" "private-app-rt" {
    vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(var.nat-gw, 0)
  }

  tags = {
    Name = "private-app-rt"
  }

}

# Private App RT Table Association with the two Private App Subnet

resource "aws_route_table_association" "privateapp_rta" {
  count = length(var.privateapp_subnets)
  route_table_id = aws_route_table.private-app-rt.id
  subnet_id      = element([aws_subnet.private-app-subnetAZ.*.id], count.index)
}
