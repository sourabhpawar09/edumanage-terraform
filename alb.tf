#ALB 
resource "aws_lb" "application_lb" {
  name               = "edu-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.logs_bucket.bucket
    enabled = true
  }

  tags = {
    Name    = "eduManage-ALB"
    Project = "EduManage"
  }
}


