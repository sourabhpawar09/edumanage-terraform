#Autoscaling Group
resource "aws_autoscaling_group" "edu_asg" {
  name                      = "edu-asg"
  desired_capacity          = 1
  max_size                  = 3
  min_size                  = 1
  vpc_zone_identifier       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.web_tg.arn]

  launch_template {
    id      = aws_launch_template.edu_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "EduManage-ASG-Instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }


}