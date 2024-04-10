#  Private Data RT Configuration

resource "aws_route_table" "private-data-rt" {
    vpc_id = aws_vpc.badevpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element([aws_nat_gateway.nat-gw.*.id], 1)
  }

  tags = {
    Name = "private-data-rt"
  }

}

# Private Data Table Association with the two Private Data Subnet

resource "aws_route_table_association" "privatedata_rta" {
  count = length(var.privatedata_subnets)
  route_table_id = aws_route_table.private-data-rt.id
  subnet_id      = element([aws_subnet.private-data-subnetAZ.*.id], count.index)
}

output "privatedata_subnets" {
    value = [aws_subnet.private-data-subnetAZ.id]
  
}
