#Load Balancer DNS Name
output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer for Edumanage"
  value       = aws_lb.application_lb.dns_name
}

# RDS Endpoint
output "rds_endpoint" {
  description = "Endpoint address of the RDS MySQL database"
  value       = aws_db_instance.edu_rds.endpoint
}

# S3 Logs Bucket Name
output "s3_logs_bucket_name" {
  description = "Name of the S3 bucket used for ALB access logs"
  value       = aws_s3_bucket.logs_bucket.id
}

# Auto Scaling Group Name
output "asg_name" {
  description = "Name of the Auto Scaling Group used for web instances"
  value       = aws_autoscaling_group.edu_asg.name
}

# Launch Template ID
output "launch_template_id" {
  description = "ID of the Launch Template used for EC2 instances"
  value       = aws_launch_template.edu_lt.id
}

# NAT Gateway Public IP
output "nat_gateway_ip" {
  description = "Elastic IP attached to the NAT Gateway"
  value       = aws_eip.nat_eip.public_ip
}

# Route 53 Hosted Zone ID
output "route53_zone_id" {
  description = "ID of the Route 53 hosted zone"
  value       = aws_route53_zone.edu_manage_zone.zone_id
}

# ACM Certificate ARN
output "acm_certificate_arn" {
  description = "ARN of the ACM SSL certificate for HTTPS"
  value       = aws_acm_certificate.edu_manage_cert.arn
}

# Web App URL (alias of ALB)
output "web_app_url" {
  description = "Main public URL to access the EduManage web application"
  value       = "http://${aws_lb.application_lb.dns_name}"
}

#SNS for CloudWarch alerts
output "sns_topic_arn" {
  description = "SNS Topic ARN for CloudWatch alert notifications"
  value       = aws_sns_topic.alerts.arn
}
