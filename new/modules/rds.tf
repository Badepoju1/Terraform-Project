# #AWS RDS Configuration

#Creating database subnet group

resource "aws_db_subnet_group" "db-subnet-group" {
    name = var.dbsubnet-name
    subnet_ids = slice([aws_subnet.private-data-subnetAZ.*.id], 0, 1)
    description = "Subnet specification for database instance"
  
}

resource "aws_db_instance" "bade-rds" {
  count =  length(var.privatedata_subnets)
  allocated_storage      = 20            # Storage size in GB for RDB
  instance_class         = var.db_instance_type #Instance Type
  engine                 = var.db_engine       #RDS Database Engine Type
  engine_version         = "5.7"         #RDS Engine Version
  username               = var.db_username      # Master username for db instance
  password               = var.db_pass    # Master password for db instance
  deletion_protection    = false         # DB protection
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.id
  vpc_security_group_ids = [aws_security_group.alb-sg.id, aws_security_group.ssh-sg.id, aws_security_group.webserver-sg.id]
  db_name                = var.db-name #Initial database name
  skip_final_snapshot = false  # Allows the system to keep a copy of the database after deleting
  tags = {
    Name = "bade-rds"
  }

}