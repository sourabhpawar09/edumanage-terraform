# EduManage – Student Management System on AWS

[![Terraform](https://img.shields.io/badge/Terraform-v1.5.7-blue)](https://www.terraform.io/)
[![AWS Region](https://img.shields.io/badge/AWS-Asia%20Pacific%20(Mumbai)-orange)](https://aws.amazon.com/)
[![Project Status](https://img.shields.io/badge/Status-Completed-brightgreen)]()

**EduManage** is a **fully cloud-native and scalable Student Management System** designed to efficiently manage **students, teachers, classes, attendance, and grades**. This project demonstrates a **real-world AWS deployment**, following best practices for **security, scalability, and maintainability**.
## Features / Highlights


- **Student & Teacher Management** – Add, update, and manage student and teacher profiles securely.
- **Attendance Tracking** – Mark and track attendance for students across classes.
- **Grades & Performance** – Record and monitor student grades with an easy-to-read dashboard.
- **Secure Cloud Deployment** – Uses **ACM certificates**, **Security Groups**, and **isolated VPC subnets** for enterprise-grade security.
- **Scalable Architecture** – Hosted on **EC2 instances behind an ALB** with **Auto Scaling** to handle variable traffic.
- **High Availability Database** – **RDS Multi-AZ** ensures redundancy and minimizes downtime.
- **Monitoring & Alerts** – **CloudWatch** monitors EC2 and ALB health, triggering alerts if needed.
- **Static Assets & Backups** – **S3 storage** for static content, backups, and logs.
- **DNS Management** – **Route 53** handles scalable domain routing.
- **Infrastructure as Code** – Fully automated deployment using **Terraform**.


## Tech Stack / AWS Services Used

| Service | Purpose in EduManage |
|---------|--------------------|
| ![EC2](https://img.shields.io/badge/EC2-%F0%9F%96%A5-blue) **Amazon EC2** | Auto-scalable compute instances for hosting the application (`launch_template.tf`, `autoscaling.tf`) |
| ![RDS](https://img.shields.io/badge/RDS-%F0%9F%97%84-orange) **Amazon RDS (Multi-AZ)** | Highly available relational database to store student, teacher, and attendance data (`rds.tf`) |
| ![ALB](https://img.shields.io/badge/ALB-%E2%9A%96%EF%B8%8F-yellow) **Application Load Balancer** | Distributes traffic across EC2 instances (`alb.tf`, `alb_listener.tf`, `alb_target_group.tf`) |
| ![S3](https://img.shields.io/badge/S3-%E2%98%81%EF%B8%8F-lightblue) **Amazon S3** | Storage for static assets, backups, and logs (`s3.tf`) |
| ![VPC](https://img.shields.io/badge/VPC-%F0%9F%8C%90-green) **VPC & Routing** | Isolated network, subnets, public/private route tables, IGW, NAT Gateway (`vpc.tf`, `public_rt.tf`, `private_rt.tf`, `internet_gateway.tf`, `nat_gateway.tf`) |
| ![SG](https://img.shields.io/badge/Security%20Groups-%F0%9F%94%90-red) **Security Groups** | Control inbound/outbound traffic for instances (`security_groups.tf`) |
| ![ACM](https://img.shields.io/badge/ACM-%F0%9F%94%91-purple) **ACM** | SSL/TLS certificates for secure HTTPS (`acm.tf`) |
| ![Route53](https://img.shields.io/badge/Route53-%F0%9F%8C%8D-blueviolet) **Route 53** | DNS management and hosted zone setup (`route53_zone.tf`, `route53_record.tf`) |
| ![CloudWatch](https://img.shields.io/badge/CloudWatch-%F0%9F%93%8A-lightgrey) **CloudWatch** | Monitoring EC2, ALB, and overall system health (`cloudwatch.tf`) |
| ![SNS](https://img.shields.io/badge/SNS-%F0%9F%93%A3-pink) **Amazon SNS** | Sends notifications/alerts for system events and alarms (linked with CloudWatch) |
| ![Terraform](https://img.shields.io/badge/Terraform-%E2%9A%99%EF%B8%8F-blue) **Terraform** | Infrastructure as Code for automated deployment and management (`provider.tf`, `outputs.tf`) |
| ⚙️ **Launch Template** | Defines EC2 instance configuration for Auto Scaling (`launch_template.tf`) |


