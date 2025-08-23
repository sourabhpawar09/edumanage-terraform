# EduManage – Student Management System on AWS

[![Terraform](https://img.shields.io/badge/Terraform-v1.5.7-blue)](https://www.terraform.io/)
[![AWS Region](https://img.shields.io/badge/AWS-Asia%20Pacific%20(Mumbai)-orange)](https://aws.amazon.com/)
[![Project Status](https://img.shields.io/badge/Status-Completed-brightgreen)]()

**EduManage** is a **fully cloud-native and scalable Student Management System** designed to efficiently manage **students, teachers, classes, attendance, and grades**. This project demonstrates a **real-world AWS deployment**, following best practices for **security, scalability, and maintainability**.

## Table of Contents
- [Key Features](#key-features)
- [Tech Stack / AWS Services Used](#tech-stack--aws-services-used)
- [Architecture Overview](#architecture-overview)
- [Docs](#optional-advanced-docs)


## Tech Stack / AWS Services Used

| Service | Purpose in EduManage |
|---------|--------------------|
| 🖥️ ![EC2](https://img.shields.io/badge/EC2-Compute-blue) **Amazon EC2** | Auto-scalable compute instances for hosting the application (`launch_template.tf`, `autoscaling.tf`) |
| 🗄️ ![RDS](https://img.shields.io/badge/RDS-Database-orange) **Amazon RDS (Multi-AZ)** | Highly available relational database for students, teachers, and attendance (`rds.tf`) |
| ⚖️ ![ALB](https://img.shields.io/badge/ALB-LoadBalancer-yellow) **Application Load Balancer** | Distributes traffic across EC2 instances (`alb.tf`, `alb_listener.tf`, `alb_target_group.tf`) |
| ☁️ ![S3](https://img.shields.io/badge/S3-Storage-lightblue) **Amazon S3** | Stores static assets, backups, and logs (`s3.tf`) |
| 🌍 ![VPC](https://img.shields.io/badge/VPC-Network-green) **VPC & Networking** | Isolated network, public/private route tables, IGW, NAT (`vpc.tf`, `public_rt.tf`, `private_rt.tf`, `internet_gateway.tf`, `nat_gateway.tf`) |
| 🔐 ![SG](https://img.shields.io/badge/SecurityGroups-Firewall-red) **Security Groups** | Controls inbound/outbound traffic (`security_groups.tf`) |
| 🔑 ![ACM](https://img.shields.io/badge/ACM-Certificate-purple) **ACM** | SSL/TLS certificates for secure HTTPS (`acm.tf`) |
| 🌐 ![Route53](https://img.shields.io/badge/Route53-DNS-blueviolet) **Route 53** | DNS management and hosted zones (`route53_zone.tf`, `route53_record.tf`) |
| 📊 ![CloudWatch](https://img.shields.io/badge/CloudWatch-Monitoring-lightgrey) **CloudWatch** | Monitors EC2, ALB, and system health (`cloudwatch.tf`) |
| 📣 ![SNS](https://img.shields.io/badge/SNS-Notifications-pink) **Amazon SNS** | Sends alerts for system events (`sns.tf`) |
| ⚙️ ![Terraform](https://img.shields.io/badge/Terraform-IaC-lightblue) **Terraform** | Infrastructure as Code for automated deployment (`provider.tf`, `outputs.tf`) |

---

## Architecture Overview

🌐 **Users / Internet**  
   |  
   v  
⚖️ **Application Load Balancer (ALB)**  
   |  
   ├─ 🖥️ **EC2 Auto Scaling Group**  
   |      ├─ Managed by **Launch Template** (`launch_template.tf`)  
   |      └─ Auto Scaling configuration (`autoscaling.tf`)  
   |  
   v  
🗄️ **Amazon RDS (Multi-AZ)**  
   └─ Stores **student, teacher, attendance, and grades data** (`rds.tf`)  

☁️ **Amazon S3**  
   └─ Stores **static assets, backups, and logs** (`s3.tf`)  

🔐 **Security Groups**  
   └─ Controls **inbound/outbound traffic** for EC2 and RDS (`security_groups.tf`)  

🌍 **VPC & Networking**  
   ├─ **VPC** (`vpc.tf`)  
   ├─ **Public Route Table** (`public_rt.tf`)  
   ├─ **Private Route Table** (`private_rt.tf`)  
   ├─ **Internet Gateway** (`internet_gateway.tf`)  
   └─ **NAT Gateway** (`nat_gateway.tf`)  

🔑 **ACM (SSL/TLS Certificates)**  
   └─ Secures HTTPS traffic (`acm.tf`)  

🌐 **Route 53**  
   └─ DNS Management & Hosted Zone (`route53_zone.tf`, `route53_record.tf`)  

📊 **CloudWatch & SNS**  
   ├─ Monitoring EC2, ALB, and system health (`cloudwatch.tf`)  
   └─ Alerts via SNS (`sns.tf`)  

⚙️ **Terraform**  
   └─ Infrastructure as Code for automated deployment and outputs (`provider.tf`, `outputs.tf`)

---

## Optional / Advanced Docs

For full deployment steps, detailed Draw.io architecture diagram, and advanced Terraform configurations, refer to the `docs` folder:


## Quick Start
Clone the repo and deploy infrastructure using Terraform:

```bash
git clone <repo-url>
cd EduManage-terraform
terraform init
terraform plan
terraform apply