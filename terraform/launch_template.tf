#EC2 INSTANCE
resource "aws_launch_template" "edu_lt" {
  name_prefix   = "EduManage-LT"
  image_id      = "ami-0f918f7e67a3323f0"
  instance_type = "t3.micro"

  key_name = "EduManage-key"
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Welcome to EduManage App - $(hostname)</h1>" > /var/www/html/index.html
              EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "EduManage-WebServer"
    }
  }

  tags = {
    Project = "EduManage"
  }
}


