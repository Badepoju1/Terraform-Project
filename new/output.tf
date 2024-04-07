# Output Declarat

output "vpc-id" {
    value = [aws_vpc.badevpc.id]
}

output "public_subnets" {
    value = [aws_subnet.public-subnetAZ.id]
  
}

output "privateapp_subnets" {
    value = [aws_subnet.private-app-subnetAZ.id]
  
}

output "privatedata_subnets" {
    value = [aws_subnet.private-data-subnetAZ.id]
  
}

output "nat-gw" {
    value = [aws_nat_gateway.nat-gw.id]
  
}

output "s3_bucket" {
  value = [aws_s3_bucket.rentzone-app.arn]
}
