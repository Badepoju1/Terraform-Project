# Public Subnet Module Configuration

resource "aws_subnet" "public-subnetAZ" {
  count             = length(var.availability_zones)
  cidr_block        = slice(var.subnet_cidr_blocks, 0, 1)[count.index]
  vpc_id            = var.vpc-id
  availability_zone = slice(var.availability_zones, 0, 1)[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnetAZ${count.index + 1}"
  }

}

# Private App Subnet Module Configuration

resource "aws_subnet" "private-app-subnetAZ" {
  count             = length(var.availability_zones)
  cidr_block        = slice(var.subnet_cidr_blocks, 2, 3)[count.index]
  vpc_id            = var.vpc-id
  availability_zone = slice(var.availability_zones, 0, 1)[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "public-app-subnetAZ${count.index + 1}"
  }

}

# Private Data Subnet Module Configuration

resource "aws_subnet" "private-data-subnetAZ" {
  count             = length(var.availability_zones)
  cidr_block        = slice(var.subnet_cidr_blocks, 4, 5)[count.index]
  vpc_id            = var.vpc-id
  availability_zone = slice(var.availability_zones, 0, 1)[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "public-data-subnetAZ${count.index + 1}"
  }

}

