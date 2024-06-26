#  Private App RT Configuration

resource "aws_route_table" "private-app-rt" {
    vpc_id = aws_vpc.badevpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat-gw.*.id, 0)
  }

  tags = {
    Name = "private-app-rt"
  }

}

# Private App RT Table Association with the two Private App Subnet

resource "aws_route_table_association" "privateapp_rta" {
  count = length(var.privateapp_subnets)
  route_table_id = aws_route_table.private-app-rt.id
  subnet_id      = element(aws_subnet.private-app-subnetAZ.*.id, count.index)
}

output "privateapp_subnets" {
    value = aws_subnet.private-app-subnetAZ[*].id
  
}