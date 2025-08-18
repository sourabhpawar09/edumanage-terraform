#SNS Topic for Notifications
resource "aws_sns_topic" "alerts" {
  name = "edumanage-alerts"
}

#SNS Subcription - Email
resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "sourabhpawar2124@gmail.com"
}

#Cloudwatch Alarm for High EC2 CPU Usage
resource "aws_cloudwatch_metric_alarm" "asg_high_cpu" {
  alarm_name          = "EduManage-ASG-High-CPU-Utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Trigger if EC2 CPU usage exceed 80% for 4 minutes"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.alerts.arn]


  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.edu_asg.name
  }

  tags = {
    Name = "ASG-High-CPU-Alarm"
  }
}


#CloudWatch Alarm for RDS Low Free Storage
resource "aws_cloudwatch_metric_alarm" "rds_low_storage" {
  alarm_name          = "EduManage-RDS-Low-Storage"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 2000000000 #2 gb in bytes
  alarm_description   = "Triggers if RDS free storage drops below 2 GB"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.alerts.arn]


  dimensions = {
    DBInstanceIdentifier = aws_db_instance.edu_rds.id
  }

  tags = {
    Name = "RDS-Low-Storage-Alarm"
  }
}

#Alarm for ALB 5XX Errors Rate
resource "aws_cloudwatch_metric_alarm" "alb_5xx_errors" {
  alarm_name          = "EduManage-ALB-5xx-Error-Rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "Trigger if ALB returns more than 10 HTTP errors in 5 minutes"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    LoadBalancer = aws_lb.application_lb.arn_suffix
  }

  tags = {
    Name = "ALB-5xx-Error-Alarm"
  }
}
