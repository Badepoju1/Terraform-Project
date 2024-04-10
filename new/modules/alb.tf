# # AWS Application Load Balancer Configuration

resource "aws_lb" "bade-alb" {
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb-sg.id]
  subnets                    = slice([aws_subnet.public-subnetAZ.*.id], 0, 1)
  enable_deletion_protection = false
  

  tags = {
    Environment = "freetier"
    Name        = "bade-alb"
  }

}

# AWS LB Target Group Configuration

resource "aws_lb_target_group" "bade-tg" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.badevpc.id
  target_type = "instance"
  target_health_state {
    enable_unhealthy_connection_termination = "false"
  }

  health_check {
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    matcher             = "200,301,302"
    port                = "traffic-port"
    interval            = 30
    unhealthy_threshold = 2
    healthy_threshold   = 5
  }
}

# AWS LB Target Group Attachment To ALB Configuration
resource "aws_lb_target_group_attachment" "bade-tga" {
  target_group_arn = aws_lb_target_group.bade-tg.arn
  target_id        = aws_lb.bade-alb.id


}

# #Creation of Listener for the ALB and Attaching it to the target group

resource "aws_lb_listener" "HTTPL" {
  load_balancer_arn = aws_lb.bade-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bade-tg.arn
  }
}

output "alb-ip" {
    value = aws_lb.bade-alb.dns_name
}
