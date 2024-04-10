# Account keys Variable Declaration

variable "access_key" {
  description = "AWS Region Infrasture Provisioning"
  type        = string
 
}

variable "secret_key" {
  description = "AWS Region Infrasture Provisioning"
  type        = string
 
}

#Region Variable Declaration
variable "region" {
  description = "AWS Region Infrasture Provisioning"
  type        = string
 
}


#VPC CIDR Block Declaration

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string

  
}


# Availablity Zone Variable Declaration

variable "availability_zones" {
  description = "List of availability zone"
  type        = list(string)
  }

# Subnet CIDR Block variable Declaration

variable "subnet_cidr_blocks" {
  description = "List of Subnet CIDR Block"
  type        = list(string)
}

# Subnets IDs variable Declaration

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
  
}

variable "privateapp_subnets" {
  description = "List of private app subnet IDs"
  type        = list(string)
  
}

variable "privatedata_subnets" {
  description = "List of private data subnet IDs"
  type        = list(string)
  
}


# NAT Gateways IDs variable Declaration 

variable "nat-gw" {
  description = "List of NAT Gateways."
  type        = list(string)
  
}

# Auto Scaling Variable Declaration

variable "launch_template_name" {
  description = "Lauch Template Name"
  type        = string
  
}

variable "ec2_image_id" {
  description = "ec2 Image ID"
  type        = string
  
}

variable "ec2_instance_type" {
  description = "ec2 Instance Name"
  type        = string
  
}



# Database Variable declaration
variable "dbsubnet-name" {
  description = "Database Subnet Name"
  type        = string
}

variable "db-name" {
  description = "Database Name"
  type        = string
}

variable "db_instance_type" {
  description = "Database Instance Type"
  type        = string
}

variable "db_engine" {
  description = "Database engine Type"
  type        = string
}

variable "db_username" {
  description = "Database Username"
  type        = string
}

variable "db_pass" {
  description = "Database Username"
  type        = string
}

