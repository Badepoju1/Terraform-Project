 # AWS Security Group Configuration

resource "aws_security_group" "ssh-sg" {
  name        = "allow_web_traffic"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = [aws_vpc.badevpc.id]


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SSH-SG"
  }

}

resource "aws_security_group" "alb-sg" {
  name        = "allow_web_traffice"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = [aws_vpc.badevpc.id]

  ingress {
    description = "HTTPS"
    from_port   = 433
    to_port     = 433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB-SG"
  }

}

resource "aws_security_group" "webserver-sg" {
  name        = "allow_web_traffice"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = [aws_vpc.badevpc.id]

  ingress {
    description = "HTTPS"
    from_port   = 433
    to_port     = 433
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.alb-sg.id]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.alb-sg.id]
  }


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.ssh-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Webserver-SG"
  }

}

resource "aws_security_group" "db-sg" {
  name        = "allow_web_traffice"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = [aws_vpc.badevpc.id]

  ingress {
    description = "MYSQL/Aurora"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.alb.sg.id]
  }


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.ssh.sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database-SG"
  }

}

