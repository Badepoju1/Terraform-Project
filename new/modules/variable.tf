# Account keys Declaration

variable "access_key" {
  description = "AWS Region Infrasture Provisioning"
  type        = string
 
}

variable "secret_key" {
  description = "AWS Region Infrasture Provisioning"
  type        = string
 
}

#Region Variable Declartion
variable "region" {
  description = "AWS Region Infrasture Provisioning"
  type        = string
 
}


#VPC CIDR Block Declaration

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string

  
}

#VPC ID Declaration

variable "vpc-id" {
  description = "VPC ID"
  type        = string


  }


# Availablity Zone Variable Declaration

variable "availability_zones" {
  description = "List of availability zone"
  type        = list(string)
  }

# Subnet CIDR Block Variable Declaration

variable "subnet_cidr_blocks" {
  description = "List of Subnet CIDR Block"
  type        = list(string)
  }
# Security Groups IDs Variable Declaration

variable "sg_ids" {
  description = "List of ALL Security Groups IDs"
  type        = list(string)
  
}


# Subnets IDs Variable Declaration

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


# Gateways IDs Variable Declaration 

variable "gateway_ids" {
  description = "List of NAT Gateways."
  type        = list(string)
  
}



# Route Tables IDS Variable Declaration

variable "rtables-ids" {
  description = "List of All Route Tables IDs"
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

variable "ec2_key_name" {
  description = "ec2 Key Name"
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

