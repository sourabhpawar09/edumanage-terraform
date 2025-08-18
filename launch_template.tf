#EC2 INSTANCE
resource "aws_launch_template" "edu_lt" {
  name_prefix   = "EduManage-LT-"
  image_id      = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (Free Tier eligible, update as per region)
  instance_type = "t2.micro"              # Free Tier eligible

  key_name = "your-key-name" # Optional: Add your SSH key name here

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
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


