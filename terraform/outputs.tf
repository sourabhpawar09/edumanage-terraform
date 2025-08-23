# VPC Outputs
output "vpc_id" {
  value = aws_vpc.edu_manage_vpc.id
}

# Subnet Outputs
output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}

# Internet Gateway
output "internet_gateway_id" {
  value = aws_internet_gateway.edu_manage_igw.id
}

# NAT Gateway
output "nat_gateway_id" {
  value = aws_nat_gateway.edu_manage_nat.id
}

# Security Groups
output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

# ALB
output "alb_dns_name" {
  value = aws_lb.edu_manage_alb.dns_name
}

output "alb_arn" {
  value = aws_lb.edu_manage_alb.arn
}

# Auto Scaling
output "autoscaling_group_name" {
  value = aws_autoscaling_group.edu_manage_asg.name
}

# RDS
output "rds_endpoint" {
  value = aws_db_instance.edu_manage_rds.endpoint
}

output "rds_instance_id" {
  value = aws_db_instance.edu_manage_rds.id
}

# S3
output "s3_bucket_name" {
  value = aws_s3_bucket.edu_manage_bucket.bucket
}

# ACM
output "acm_certificate_arn" {
  value = aws_acm_certificate.edu_manage_cert.arn
}

# Route 53
output "route53_zone_id" {
  value = aws_route53_zone.edu_manage_zone.zone_id
}

output "route53_record_name" {
  value = aws_route53_record.edu_manage_record.fqdn
}
