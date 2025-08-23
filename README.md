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
| **Amazon EC2** | Auto-scalable compute instances for hosting the application (`launch_template.tf`, `autoscaling.tf`) |
| **Amazon RDS (Multi-AZ)** | Highly available relational database to store student, teacher, and attendance data (`rds.tf`) |
| **Application Load Balancer (ALB)** | Distributes traffic across EC2 instances (`alb.tf`, `alb_listener.tf`, `alb_target_group.tf`) |
| **Amazon S3** | Storage for static assets, backups, and logs (`s3.tf`) |
| **Amazon VPC** | Secure and isolated network with subnets, routing, and gateways (`vpc.tf`, `private_rt.tf`, `public_rt.tf`) |
| **Internet Gateway (IGW)** | Provides internet access to public subnets (`internet_gateway.tf`) |
| **NAT Gateway** | Enables internet access for private subnets (`nat_gateway.tf`) |
| **Security Groups** | Control inbound/outbound traffic for instances (`security_groups.tf`) |
| **AWS Certificate Manager (ACM)** | Manages SSL/TLS certificates for secure HTTPS (`acm.tf`) |
| **Route 53** | DNS management and hosted zone setup (`route53_zone.tf`, `route53_record.tf`) |
| **CloudWatch** | Monitoring and alerts for instances and load balancers (`cloudwatch.tf`) |
| **Terraform** | Infrastructure as Code to automate and manage all resources (`provider.tf`, `outputs.tf`) |


