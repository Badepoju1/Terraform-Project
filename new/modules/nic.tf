resource "aws_network_interface" "bade-nic" {
 subnet_id =  slice(aws_subnet.public-subnetAZ.*.id, 0, 1)
 security_groups = [ aws_security_group.webserver-sg.id ]
 
}

resource "aws_network_interface_attachment" "bade-nice" {
  instance_id = aws_launch_template.webserver_launch_template.id
  network_interface_id = aws_network_interface.bade-nic.id
  device_index = slice(aws_autoscaling_group.auto_scaling_group.id, 0, 1)
}