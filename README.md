# EduManage – Student Management System on AWS

[![Terraform](https://img.shields.io/badge/Terraform-v1.5.7-blue)](https://www.terraform.io/)
[![AWS Region](https://img.shields.io/badge/AWS-Asia%20Pacific%20(Mumbai)-orange)](https://aws.amazon.com/)
[![Project Status](https://img.shields.io/badge/Status-Completed-brightgreen)]()

**EduManage** is a **fully cloud-native and scalable Student Management System** designed to efficiently manage **students, teachers, classes, attendance, and grades**. This project demonstrates a **real-world AWS deployment**, following best practices for **security, scalability, and maintainability**.

---

## Table of Contents
- [Key Features](#key-features)
- [Tech Stack / AWS Services Used](#tech-stack--aws-services-used)
- [Architecture Diagram](#architecture-diagram)
- [Quick Start](#quick-start)
- [Docs](#optional--advanced-docs)

---

## Key Features
- Manage students, teachers, classes, attendance, and grades
- Auto-scalable EC2 instances for high traffic
- Multi-AZ RDS for high availability
- Secure HTTPS using ACM
- Automated infrastructure via Terraform
- Monitoring and alerts with CloudWatch & SNS

---

## Tech Stack / AWS Services Used

| Service | Purpose in EduManage | Terraform File |
|---------|--------------------|----------------|
| 🖥️ ![EC2](https://img.shields.io/badge/EC2-Compute-blue) **Amazon EC2** | Auto-scalable compute instances for hosting the application | [`launch_template.tf`](launch_template.tf), [`autoscaling.tf`](autoscaling.tf) |
| 🗄️ ![RDS](https://img.shields.io/badge/RDS-Database-orange) **Amazon RDS (Multi-AZ)** | Highly available relational database for students, teachers, and attendance | [`rds.tf`](rds.tf) |
| ⚖️ ![ALB](https://img.shields.io/badge/ALB-LoadBalancer-yellow) **Application Load Balancer** | Distributes traffic across EC2 instances | [`alb.tf`](alb.tf), [`alb_listener.tf`](alb_listener.tf), [`alb_target_group.tf`](alb_target_group.tf) |
| ☁️ ![S3](https://img.shields.io/badge/S3-Storage-lightblue) **Amazon S3** | Stores static assets, backups, and logs | [`s3.tf`](s3.tf) |
| 🌍 ![VPC](https://img.shields.io/badge/VPC-Network-green) **VPC & Networking** | Isolated network, public/private route tables, IGW, NAT Gateway | [`vpc.tf`](vpc.tf), [`public_rt.tf`](public_rt.tf), [`private_rt.tf`](private_rt.tf), [`internet_gateway.tf`](internet_gateway.tf), [`nat_gateway.tf`](nat_gateway.tf) |
| 🔐 ![SG](https://img.shields.io/badge/SecurityGroups-Firewall-red) **Security Groups** | Controls inbound/outbound traffic for EC2 and RDS | [`security_groups.tf`](security_groups.tf) |
| 🔑 ![ACM](https://img.shields.io/badge/ACM-Certificate-purple) **ACM** | SSL/TLS certificates for secure HTTPS | [`acm.tf`](acm.tf) |
| 🌐 ![Route53](https://img.shields.io/badge/Route53-DNS-blueviolet) **Route 53** | DNS management and hosted zones | [`route53_zone.tf`](route53_zone.tf), [`route53_record.tf`](route53_record.tf) |
| 📊 ![CloudWatch](https://img.shields.io/badge/CloudWatch-Monitoring-lightgrey) **CloudWatch** | Monitors EC2, ALB, and system health | [`cloudwatch.tf`](cloudwatch.tf) |
| 📣 ![SNS](https://img.shields.io/badge/SNS-Notifications-pink) **Amazon SNS** | Sends alerts for system events | [`sns.tf`](sns.tf) |
| ⚙️ ![Terraform](https://img.shields.io/badge/Terraform-IaC-lightblue) **Terraform** | Infrastructure as Code for automated deployment | [`provider.tf`](provider.tf), [`outputs.tf`](outputs.tf) |

---


## Architecture Overview

**🌐 Users / Internet**  
&nbsp;&nbsp;↓  
**⚖️ Application Load Balancer (ALB)**  
&nbsp;&nbsp;├─ **🖥️ EC2 Auto Scaling Group**  
&nbsp;&nbsp;&nbsp;&nbsp;├─ Managed by **Launch Template** (`launch_template.tf`)  
&nbsp;&nbsp;&nbsp;&nbsp;└─ Auto Scaling configuration (`autoscaling.tf`)  
&nbsp;&nbsp;↓  
**🗄️ Amazon RDS (Multi-AZ)**  
&nbsp;&nbsp;└─ Stores **student, teacher, attendance, and grades data** (`rds.tf`)  

**☁️ Amazon S3**  
&nbsp;&nbsp;└─ Stores **static assets, backups, and logs** (`s3.tf`)  

**🔐 Security Groups**  
&nbsp;&nbsp;└─ Controls **inbound/outbound traffic** for EC2 and RDS (`security_groups.tf`)  

**🌍 VPC & Networking**  
&nbsp;&nbsp;├─ **VPC** (`vpc.tf`)  
&nbsp;&nbsp;├─ **Public Route Table** (`public_rt.tf`)  
&nbsp;&nbsp;├─ **Private Route Table** (`private_rt.tf`)  
&nbsp;&nbsp;├─ **Internet Gateway** (`internet_gateway.tf`)  
&nbsp;&nbsp;└─ **NAT Gateway** (`nat_gateway.tf`)  

**🔑 ACM (SSL/TLS Certificates)**  
&nbsp;&nbsp;└─ Secures **HTTPS traffic** (`acm.tf`)  

**🌐 Route 53**  
&nbsp;&nbsp;└─ DNS Management & Hosted Zone (`route53_zone.tf`, `route53_record.tf`)  

**📊 CloudWatch & SNS**  
&nbsp;&nbsp;├─ Monitoring EC2, ALB, and system health (`cloudwatch.tf`)  
&nbsp;&nbsp;└─ Alerts via SNS (`sns.tf`)  

**⚙️ Terraform**  
&nbsp;&nbsp;└─ Infrastructure as Code for automated deployment and outputs (`provider.tf`, `outputs.tf`)



## Optional / Advanced Docs

For full deployment steps, detailed Draw.io architecture diagram, and advanced Terraform configurations, refer to the `docs` folder:

---

## Quick Start

Clone the repository and deploy the infrastructure using Terraform:

```bash
git clone <repo-url>
cd EduManage-terraform
terraform init          # Initialize Terraform
terraform plan          # Preview resources to be created
terraform apply         # Apply and deploy infrastructure
terraform apply         # Apply and deploy infrastructure
