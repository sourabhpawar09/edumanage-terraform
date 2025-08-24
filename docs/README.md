# EduManage – Documentation  

EduManage is a **cloud-native Student Management System** deployed on **Amazon Web Services (AWS)** using **Terraform** for Infrastructure as Code (IaC).  
The project demonstrates how to design and implement a **production-grade 3-tier architecture** that is scalable, secure, and highly available.  

This document provides a **detailed explanation** of the project, including:  
✦ The real-world problem it solves

✦ Design objectives and goals

✦ Architecture breakdown with reasoning behind each component

✦ Security considerations & best practices

✦ Backup & recovery strategy

✦ Tech Stack & tools used

✦ Step-by-step deployment instructions

✦ Cost considerations and optimizations

✦ Future enhancements for making the system enterprise-ready

✦ Architecture diagram reference





---
![1-Real-World-Problem](https://img.shields.io/badge/1-Real--World--Problem-blue?style=for-the-badge&logo=aws)



Educational institutions handle sensitive, high-volume data (students, teachers, classes, attendance, exams, fees) and need secure, always-available access. Traditional/on-prem systems typically suffer from:
- Limited scalability during peaks (admissions, results).
- Single points of failure and poor disaster recovery.
- High operational overhead (patching, backups, hardware refresh).
- Weak network segmentation and inconsistent security hardening.
- Slow, error-prone provisioning without Infrastructure as Code.

**EduManage** addresses these by moving to a cloud-native, 3-tier architecture on AWS with automated, repeatable provisioning using Terraform.

---

## 2) Design Objectives & Goals

**Non-Functional Objectives**
- **High Availability:** Multi-AZ components where applicable; load balanced stateless app tier.
- **Scalability:** Auto Scaling for EC2; decoupled tiers.
- **Security by Design:** Private subnets for app/DB; least-privilege Security Groups; TLS at the edge.
- **Observability:** CloudWatch metrics/alarms and logs.
- **Repeatability:** Full IaC with Terraform; idempotent, version-controlled deployments.
- **Cost Awareness:** Right-size instances, minimize NAT exposure, destroy non-prod when idle.

**Functional Scope (infra)**
- Network baseline (VPC, subnets, routing, IGW/NAT).
- Public entry via ALB → EC2 app tier.
- Managed relational DB via RDS (Multi-AZ).
- DNS & certificate plumbing (Route 53 + ACM).
- Object storage for static assets/logs via S3.

---

## 3) Architecture Breakdown & Rationale

### 3.1) Networking Layer (VPC & Subnets)
- **VPC (10.0.0.0/16):** Isolates EduManage workloads from other AWS accounts/projects. Provides CIDR space for subnets.
- **Public Subnets (2 AZs):** Host Application Load Balancer (ALB) and NAT Gateways. Required for internet-facing entry points.
- **Private App Subnets (2 AZs):** Host EC2 Auto Scaling group. Prevents direct public internet access; only ALB and NAT can reach them.
- **Private DB Subnets (2 AZs):** Dedicated for RDS. No outbound internet; accessed only from app tier.
- **Internet Gateway:** Enables outbound internet access for public subnets.
- **NAT Gateways:** Allow private EC2 instances to download OS updates and packages without being exposed publicly.
- **Route Tables:** Custom public/private routing ensures each subnet only has necessary access.

**Rationale:**  
Segregated tiers improve security, fault tolerance, and scalability. NAT reduces attack surface by restricting inbound paths.

---

### 3.2) Compute Layer (EC2 & Auto Scaling)
- **Launch Template:** Standardizes EC2 configuration (AMI, instance type, security groups, bootstrap scripts).
- **Auto Scaling Group (Multi-AZ):** Ensures EC2 fleet scales dynamically during exam/admission peaks and recovers from failures.
- **Placement in Private Subnets:** EC2s are not publicly accessible; traffic always comes via ALB.

**Rationale:**  
Decouples compute from infra, supports elasticity, ensures HA, reduces operational load.

---

### 3.3) Load Balancing Layer (ALB)
- **Application Load Balancer:** Routes HTTP(S) traffic from clients → EC2 instances.
- **HTTPS Listener (443):** Enforces TLS termination using ACM certificates.
- **Target Group:** Maintains healthy backend EC2s, checked via health checks.

**Rationale:**  
ALB abstracts away single point of failure, adds SSL/TLS offloading, improves availability, enables blue/green if extended with CodeDeploy.

---

### 3.4) Database Layer (Amazon RDS)
- **RDS MySQL (Multi-AZ):** Provides relational DB backend with automatic failover.
- **DB Subnet Group:** Ensures DB is deployed only in isolated private subnets across AZs.
- **Parameter/Option Groups:** Allow custom DB tuning.
- **Security Group:** Restricts DB access to app-tier EC2s only.

**Rationale:**  
Ensures consistency, durability, fault tolerance, and compliance with HA requirements.

---

### 3.5) Storage Layer (S3)
- **S3 Bucket (static assets):** Store student photos, documents, and app logs.
- **Versioning:** Enabled to avoid accidental overwrites.
- **Encryption (SSE-S3/KMS):** Protects sensitive data.

**Rationale:**  
Offloads static assets from EC2 → reduces cost, improves scalability, ensures durability (11 9s).

---

### 3.6) DNS & TLS (Route 53 + ACM)
- **Route 53 Hosted Zone:** Maps human-readable domain → ALB DNS.
- **ACM (Certificate Manager):** Issues free TLS certs; integrated with ALB for HTTPS.
- **CNAME Validation:** Automated Terraform validation process.

**Rationale:**  
Delivers secure HTTPS endpoints with custom domain, critical for production-grade deployments.

---

### 3.7) Observability (CloudWatch)
- **CloudWatch Alarms:** Monitors EC2 CPU, RDS storage, ALB latency.
- **Log Groups:** Capture app and system logs.
- **Dashboards:** Central view for operational health.

**Rationale:**  
Adds visibility, proactive monitoring, and helps detect failures before users notice.

---

### 3.8) IaC & Repeatability (Terraform)
- **Provider & Backend Config:** AWS provider set to Mumbai (ap-south-1), Terraform state stored in S3/DynamoDB for team usage.
- **Split Modules/Files:** Logical separation (`vpc.tf`, `alb.tf`, `rds.tf`, etc.) → easier management.
- **Idempotency:** Safe re-runs, avoids drift, version-controlled infra in GitHub.

**Rationale:**  
Makes deployments auditable, reusable, and automation-ready.

---

### 3.9) Security Layer (IAM & Security Groups)
- **IAM Roles:** EC2 → S3 (read/write), CloudWatch logging permissions.
- **Security Groups:** 
  - ALB SG → Allows HTTP/HTTPS from internet.  
  - EC2 SG → Accepts traffic only from ALB.  
  - RDS SG → Accepts traffic only from EC2.  
- **NACLs (Optional):** Extra subnet-level filtering.  
- **KMS:** Encrypts RDS snapshots, S3 objects, and secrets.

**Rationale:**  
Implements defense-in-depth, least privilege, and compliance-ready design.

---

### 3.10) Backup & Recovery
- **RDS Automated Backups:** Daily snapshots with retention (7–30 days).
- **S3 Versioning + Lifecycle:** Protects against accidental deletion and optimizes storage.
- **Terraform State:** Stored in S3 with DynamoDB locking to avoid corruption.

**Rationale:**  
Ensures disaster recovery, long-term durability, and infra reliability.

---

## 4) Security Considerations & Best Practices

EduManage follows **security-by-design principles** to ensure sensitive student and institutional data is protected at all times.

### 4.1) Network Security
- **Private Subnets for App & DB:** Prevents direct internet access; only ALB and NAT can reach them.
- **Security Groups:** Least-privilege rules; only necessary ports open (HTTP/HTTPS for ALB, MySQL for DB).
- **NACLs (Optional):** Extra subnet-level filtering at the subnet level.

### 4.2) Data Protection
- **Encryption at Rest:** S3 buckets use SSE-S3/KMS; RDS uses AES-256 encryption.
- **Encryption in Transit:** TLS/HTTPS enforced via ALB and ACM certificates.

### 4.3) Identity & Access Management
- **IAM Roles for EC2:** Grants minimum required permissions for app to access S3, CloudWatch, etc.
- **IAM Policies:** Fine-grained access controls for Terraform deployments.

### 4.4) Logging & Monitoring
- **CloudWatch Logs & Alarms:** Track suspicious activity, resource usage, and failures.
- **Audit Trails:** AWS CloudTrail enabled for all critical actions.

**Rationale:**  
Implementing security best practices at network, compute, data, and access levels ensures EduManage is **resilient against attacks**, compliant with standards, and ready for enterprise deployment.
