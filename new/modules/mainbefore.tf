# ### Infrastructure Provisioning for A 3 Tier Architecture with high scalabilty


# # AWS Provider Configuration

# provider "aws" {
#   region     = "us-east-1"


# }
# # # AWS VPC Configuration

# # resource "aws_vpc" "badeVPC" {
# #   cidr_block = "10.0.0.0/16"

# #   tags = {
# #     Name = "badeVPC"
# #   }
# # }

# # # # AWS Public-Subnets Configuration

# # resource "aws_subnet" "public-subnetAZ1" {
# #   cidr_block        = "10.0.0.0/24"
# #   vpc_id            = aws_vpc.badeVPC.id
# #   availability_zone = "us-east-1a"
# #   #map_public_ip_on_launch = true

# #   tags = {
# #     Name = "public-subnetAZ1"
# #   }

# # }

# # resource "aws_subnet" "public-subnetAZ2" {
# #   cidr_block        = "10.0.1.0/24"
# #   vpc_id            = aws_vpc.badeVPC.id
# #   availability_zone = "us-east-1b"
# #   #map_public_ip_on_launch = true #Auto Assignment of Public IP Address

# #   tags = {
# #     Name = "public-subnetAZ2"
# #   }

# # }

# # # # AWS Private App-Subnets Configuration

# # resource "aws_subnet" "privateApp-subnetAZ1" {
# #   cidr_block        = "10.0.2.0/24"
# #   vpc_id            = aws_vpc.badeVPC.id
# #   availability_zone = "us-east-1a"

# #   tags = {
# #     Name = "privateApp-subnetAZ1"
# #   }

# # }

# # resource "aws_subnet" "privateApp-subnetAZ2" {
# #   cidr_block        = "10.0.3.0/24"
# #   vpc_id            = aws_vpc.badeVPC.id
# #   availability_zone = "us-east-1b"

# #   tags = {
# #     Name = "privateApp-subnetAZ2"
# #   }

# # }

# # # # AWS Private Data-Subnets Configuration

# # resource "aws_subnet" "privateData-subnetAZ1" {
# #   cidr_block        = "10.0.4.0/24"
# #   vpc_id            = aws_vpc.badeVPC.id
# #   availability_zone = "us-east-1a"

# #   tags = {
# #     Name = "privateData-subnetAZ1"
# #   }

# # }

# # resource "aws_subnet" "privateData-subnetAZ2" {
# #   cidr_block        = "10.0.5.0/24"
# #   vpc_id            = aws_vpc.badeVPC.id
# #   availability_zone = "us-east-1b"

# #   tags = {
# #     Name = "privateData-subnetAZ2"
# #   }

# # }

# # # AWS Internet Gateway Configuration

# resource "aws_internet_gateway" "Public-IGW" {
#   vpc_id = aws_vpc.badeVPC.id

#   tags = {
#     Name = "Public-IGW"
#   }

# }

# # # AWS EIP Configuration

# resource "aws_eip" "NAT-EIP" {
#   domain = "vpc"

#   tags = {
#     Name = "NAT-EIP"
#   }
# }


# # # AWS NAT Gateway Configuration

# resource "aws_nat_gateway" "NAT-AZ1" {
#   allocation_id = aws_eip.NAT-EIP.id
#   subnet_id     = aws_subnet.public-subnetAZ1.id

#   tags = {
#     Name = "NAT-AZ1"
#   }
# }

# resource "aws_nat_gateway" "NAT-AZ2" {
#   allocation_id = aws_eip.NAT-EIP.id
#   subnet_id     = aws_subnet.public-subnetAZ2.id

#   tags = {
#     Name = "NAT-AZ2"
#   }
# }

# # # AWS Public Routes Table Configuration

# resource "aws_route_table" "Public-RT" {
#   vpc_id = aws_vpc.badeVPC.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.Public-IGW.id
#   }

#   tags = {
#     Name = "Public-RT"
#   }

# }

# # #AWS Public Route Table Association with the two Public Subnet

# resource "aws_route_table_association" "RTA1" {

#   route_table_id = aws_route_table.Public-RT.id
#   subnet_id      = aws_subnet.public-subnetAZ1.id
# }

# resource "aws_route_table_association" "RTA2" {

#   route_table_id = aws_route_table.Public-RT.id
#   subnet_id      = aws_subnet.public-subnetAZ2.id
# }

# # # 2 Private AWS Route Table Configuration

# resource "aws_route_table" "Private-RT1" {
#   vpc_id = aws_vpc.badeVPC.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.NAT-AZ1.id
#   }

#   tags = {
#     Name = "Private-RT1"
#   }

# }

# # resource "aws_route_table" "Private-RT2" {
# #   vpc_id = aws_vpc.badeVPC.id

# #   route {
# #     cidr_block = "0.0.0.0/0"
# #     gateway_id = aws_nat_gateway.NAT-AZ2.id
# #   }

# #   tags = {
# #     Name = "Private-RT2"
# #   }

# # }

# # #AWS Private Route Table Association with the two Private Subnet in AZ1

# # resource "aws_route_table_association" "RTA3" {

# #   route_table_id = aws_route_table.Private-RT1.id
# #   subnet_id      = aws_subnet.privateApp-subnetAZ1.id
# # }

# # resource "aws_route_table_association" "RTA4" {

# #   route_table_id = aws_route_table.Private-RT1.id
# #   subnet_id      = aws_subnet.privateData-subnetAZ1.id
# # }

# # #AWS Private Route Table Association with the two Private Subnet in AZ2

# # resource "aws_route_table_association" "RTA5" {

# #   route_table_id = aws_route_table.Private-RT2.id
# #   subnet_id      = aws_subnet.privateApp-subnetAZ2.id
# # }

# # resource "aws_route_table_association" "RTA6" {

# #   route_table_id = aws_route_table.Private-RT2.id
# #   subnet_id      = aws_subnet.privateData-subnetAZ2.id
# # }


# # # # AWS Security Group Configuration

# # resource "aws_security_group" "SSH-SG" {
# #   name        = "allow_web_traffic"
# #   description = "Allow inbound traffic and all outbound traffic"
# #   vpc_id      = aws_vpc.badeVPC.id


# #   ingress {
# #     description = "SSH"
# #     from_port   = 22
# #     to_port     = 22
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
# #   tags = {
# #     Name = "SSH-SG"
# #   }

# # }

# # resource "aws_security_group" "ALB-SG" {
# #   name        = "allow_web_traffice"
# #   description = "Allow inbound traffic and all outbound traffic"
# #   vpc_id      = aws_vpc.badeVPC.id

# #   ingress {
# #     description = "HTTPS"
# #     from_port   = 433
# #     to_port     = 433
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   ingress {
# #     description = "HTTP"
# #     from_port   = 80
# #     to_port     = 80
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   tags = {
# #     Name = "ALB-SG"
# #   }

# # }

# # resource "aws_security_group" "Webserver-SG" {
# #   name        = "allow_web_traffice"
# #   description = "Allow inbound traffic and all outbound traffic"
# #   vpc_id      = aws_vpc.badeVPC.id

# #   ingress {
# #     description = "HTTPS"
# #     from_port   = 433
# #     to_port     = 433
# #     protocol    = "tcp"
# #     cidr_blocks = [aws_security_group.ALB-SG.id]
# #   }

# #   ingress {
# #     description = "HTTP"
# #     from_port   = 80
# #     to_port     = 80
# #     protocol    = "tcp"
# #     cidr_blocks = [aws_security_group.ALB-SG.id]
# #   }


# #   ingress {
# #     description = "SSH"
# #     from_port   = 22
# #     to_port     = 22
# #     protocol    = "tcp"
# #     cidr_blocks = [aws_security_group.SSH-SG.id]
# #   }

# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   tags = {
# #     Name = "Webserver-SG"
# #   }

# # }

# # resource "aws_security_group" "Database-SG" {
# #   name        = "allow_web_traffice"
# #   description = "Allow inbound traffic and all outbound traffic"
# #   vpc_id      = aws_vpc.badeVPC.id

# #   ingress {
# #     description = "MYSQL/Aurora"
# #     from_port   = 3306
# #     to_port     = 3306
# #     protocol    = "tcp"
# #     cidr_blocks = [aws_security_group.ALB-SG.id]
# #   }


# #   ingress {
# #     description = "SSH"
# #     from_port   = 22
# #     to_port     = 22
# #     protocol    = "tcp"
# #     cidr_blocks = [aws_security_group.SSH-SG.id]
# #   }

# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   tags = {
# #     Name = "Database-SG"
# #   }

# # }

# # resource "aws_security_group" "EFS-SG" {
# #   name        = "allow_web_traffice"
# #   description = "Allow inbound traffic and all outbound traffic"
# #   vpc_id      = aws_vpc.badeVPC.id

#   # ingress {
#   #     description = "NFS"
#   #     from_port = 2049
#   #     to_port = 2049
#   #     protocol = "tcp"
#   #     cidr_blocks = [aws_security_group.EFS-SG.id]
#   # }


# #   ingress {
# #     description = "SSH"
# #     from_port   = 22
# #     to_port     = 22
# #     protocol    = "tcp"
# #     cidr_blocks = [aws_security_group.SSH-SG.id]
# #   }
# #   ingress {
# #     description = "NFS"
# #     from_port   = 2049
# #     to_port     = 2049
# #     protocol    = "tcp"
# #     cidr_blocks = [aws_security_group.Webserver-SG.id]
# #   }

# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   tags = {
# #     Name = "EFS-SG"
# #   }

# # }

# # # AWS Application Load Balancer Configuration

# resource "aws_lb" "bade-ALB" {
#   internal                   = false
#   load_balancer_type         = "application"
#   security_groups            = [aws_security_group.ALB-SG.id]
#   subnets                    = [aws_subnet.public-subnetAZ1.id, aws_subnet.public-subnetAZ2.id]
#   enable_deletion_protection = false


#   tags = {
#     Environment = "freetier"
#     Name        = "bade-ALB"
#   }

# }

# # AWS LB Target Group Configuration

# resource "aws_lb_target_group" "bade-TG" {
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.badeVPC.id

#   health_check {
#     path                = "/"
#     protocol            = "HTTP"
#     timeout             = 5
#     interval            = 30
#     unhealthy_threshold = 2
#     healthy_threshold   = 2
#   }
# }

# # AWS LB Target Group Attachment To ALB Configuration
# resource "aws_lb_target_group_attachment" "bade-TGA" {
#   target_group_arn = aws_lb_target_group.bade-TG.arn
#   target_id        = aws_lb.bade-ALB.id


# }

# # #Creation of Listener for the ALB and Attaching it to the target group

# resource "aws_lb_listener" "HTTPL" {
#   load_balancer_arn = aws_lb.bade-ALB.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.bade-TG.arn
#   }
# }

# # # AWS EC2 Instance (Webserver) configuration

# resource "aws_instance" "webserver1" {
#   ami                         = "ami-07d9b9ddc6cd8dd30"
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.privateApp-subnetAZ1.id
#   associate_public_ip_address = false # Enable Auto Assignment of Public IP Address
#   security_groups             = [aws_security_group.ALB-SG.id, aws_security_group.Webserver-SG.id, aws_security_group.SSH-SG.id]

#   tags = {
#     Name = "webserver1"
#   }
# }
# resource "aws_instance" "webserver2" {
#   ami                         = "ami-07d9b9ddc6cd8dd30"
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.privateApp-subnetAZ2.id
#   associate_public_ip_address = false
#   security_groups             = [aws_security_group.ALB-SG.id, aws_security_group.Webserver-SG.id, aws_security_group.SSH-SG.id]

#   tags = {
#     Name = "webserver2"
#   }
# }

# # #AWS RDS Configuration

# # resource "aws_db_instance" "bade-rds" {
# #   allocated_storage      = 20            # Storage size in GB for RDB
# #   instance_class         = "db.t2.micro" #Instance Type
# #   engine                 = "mysql"       #RDS Database Engine Type
# #   engine_version         = "5.7"         #RDS Engine Version
# #   username               = "master"      # Master username for db instance
# #   password               = "2Ronaldo"    # Master password for db instance
# #   deletion_protection    = false         # DB protection
# #   db_subnet_group_name   = aws_subnet.privateApp-subnetAZ1.id
# #   vpc_security_group_ids = [aws_security_group.Database-SG.id, aws_security_group.SSH-SG.id, aws_security_group.Webserver-SG.id]
# #   db_name                = "app-db" #Initial database name

# #   tags = {
# #     Name = "bade-rds"
# #   }

# # }

# # #AWS EFS FileSystem Configuration

# # resource "aws_efs_file_system" "bade-efs" {
# #   creation_token         = "bade-efs"
# #   performance_mode       = "generalPurpose"
# #   encrypted              = false
# #   availability_zone_name = "us-east-1"
# #   protection {
# #     replication_overwrite = "DISABLED"
# #   }

# #   tags = {
# #     Name = "bade-efs"
# #   }
# # }

# # # AWS Mount Target in 2 Two Private Subnet

# # resource "aws_efs_mount_target" "efs-MT1" {
# #   file_system_id  = aws_efs_file_system.bade-efs.id
# #   subnet_id       = aws_subnet.privateData-subnetAZ1.id
# #   security_groups = [aws_security_group.Database-SG.id, aws_security_group.EFS-SG.id, aws_security_group.Webserver-SG.id]
# # }

# # resource "aws_efs_mount_target" "efs-MT2" {
# #   file_system_id  = aws_efs_file_system.bade-efs.id
# #   subnet_id       = aws_subnet.privateData-subnetAZ2.id
# #   security_groups = [aws_security_group.Database-SG.id, aws_security_group.EFS-SG.id, aws_security_group.Webserver-SG.id]
# # }

# # #AWS Instance Configuration on the Public Subnet to server as Setup Server

# # resource "aws_instance" "webserver-setup" {
# #   ami                         = "ami-07d9b9ddc6cd8dd30"
# #   instance_type               = "t2.micro"
# #   subnet_id                   = aws_subnet.privateApp-subnetAZ2.id
# #   associate_public_ip_address = true
# #   security_groups             = [aws_security_group.ALB-SG.id, aws_security_group.Webserver-SG.id, aws_security_group.SSH-SG.id]

# #   tags = {
# #     Name = "webserver-setup"
# #   }

# #   #Mount Target and Public EC2 Instance Attachment
# #   user_data = <<-EOF
# #  #!/bin/bash

# # #1. create the html directory and mount the efs to it
# # sudo su -
# # sudo apt-get update -y
# # mkdir -p /var/www/html
# # sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.bade-efs.dns_name}:/ /var/www/html

# # #2. install apache 
# # sudo apt-get install -y httpd httpd-tools mod_ssl
# # sudo systemctl enable httpd 
# # sudo systemctl start httpd

# # #3. install php 7.4
# # sudo amazon-linux-extras enable php7.4
# # sudo apt-get clean metadata
# # sudo apt-get install php php-common php-pear -y
# # sudo apt-get install php-{cgi,curl,mbstring,gd,mysqlnd,gettext,json,xml,fpm,intl,zip} -y

# # #4. install mysql5.7
# # sudo rpm -Uvh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
# # sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
# # sudo yum install mysql-community-server -y
# # sudo systemctl enable mysqld
# # sudo systemctl start mysqld

# # #5. set permissions
# # sudo usermod -a -G apache ec2-user
# # sudo chown -R ec2-user:apache /var/www
# # sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
# # sudo find /var/www -type f -exec sudo chmod 0664 {} \;
# # chown apache:apache -R /var/www/html 

# # #6. download wordpress files
# # wget https://wordpress.org/latest.tar.gz
# # tar -xzf latest.tar.gz
# # cp -r wordpress/* /var/www/html/

# # #7. create the wp-config.php file
# # cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# # #8. edit the wp-config.php file
# # nano /var/www/html/wp-config.php

# # #9. restart the webserver
# # service httpd restart

# # EOF
# # }
