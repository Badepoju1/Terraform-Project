# create a launch template
# terraform aws launch template
resource "aws_launch_template" "webserver_launch_template" {
  name          = var.launch_template_name
  image_id      = var.ec2_image_id
  instance_type = var.ec2_instance_type
  key_name      = aws_key_pair.bade-key.key_name
  description   = "webserver launch template"
  iam_instance_profile {
     name = aws_iam_instance_profile.bade_profile.name
  }

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
}

# create auto scaling group
# terraform aws autoscaling group
resource "aws_autoscaling_group" "auto_scaling_group" {
  vpc_zone_identifier = slice([aws_subnet.public-subnetAZ.*.id], 0, 1)
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  name                = "bade-asg"
  health_check_type   = "ELB"

  launch_template {
    name    = aws_launch_template.webserver_launch_template.name
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes      = [target_group_arns]
  }
}

# attach auto scaling group to alb target group
# terraform aws autoscaling attachment
resource "aws_autoscaling_attachment" "asg_alb_target_group_attachment" {
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.id
  lb_target_group_arn    = aws_lb_target_group.bade-tg.arn
}
