resource "aws_network_interface" "bade-nic" {
  subnet_id =  element(aws_subnet.public-subnetAZ.*.id, 0)
 security_groups = [ aws_security_group.webserver-sg.id ]
 
}

resource "aws_network_interface_attachment" "bade-nice" {
  instance_id = aws_launch_template.webserver_launch_template.id
  network_interface_id = aws_network_interface.bade-nic.id
  device_index = aws_launch_template.webserver_launch_template.id
}