# 🚀 Scalable Web Platform - Terraform Infrastructure

## 📋 Project Overview

This Terraform project creates a **complete, production-ready, scalable web platform** on AWS with:

- **VPC** with public/private subnets across 2 AZs
- **NAT Gateways** for private subnet internet access
- **Application Load Balancer** with SSL termination
- **ECS Fargate** cluster for containerized applications
- **RDS Database** for data persistence
- **SSL Certificate** with automatic DNS validation
- **Security Groups** with least-privilege access
- **IAM Roles** for ECS tasks

## 🎯 Final Architecture

```
Internet → Route53 → ALB (HTTPS) → ECS Containers → RDS Database
                      ↓
                 NAT Gateway → Private Subnets
```

**Your application will be accessible at:** ` YourProjectName.YourDomainName.com`

---

## 📚 **CHRONOLOGICAL DEPLOYMENT ORDER**

### **PHASE 1: FOUNDATION INFRASTRUCTURE** ✅

#### **Step 1: VPC & Networking**
- **Module:** `modules/vpc/`
- **Creates:** VPC, subnets, internet gateway, route tables
- **Dependencies:** None
- **Status:** ✅ Complete

#### **Step 2: NAT Gateways**
- **Module:** `modules/nat-gateway/`
- **Creates:** Elastic IPs, NAT Gateways for private subnet internet access
- **Dependencies:** VPC module (public subnets, internet gateway)
- **Status:** ✅ Complete

#### **Step 3: Security Groups**
- **Module:** `modules/security-groups/`
- **Creates:** ALB security group, ECS security group with proper rules
- **Dependencies:** VPC module (VPC ID)
- **Status:** ✅ Complete

#### **Step 4: IAM Roles**
- **Module:** `modules/iam-roles/`
- **Creates:** ECS task execution role, ECS task role with policies
- **Dependencies:** None
- **Status:** 📋 Planned

---

### **PHASE 2: SSL & LOAD BALANCER** ✅

#### **Step 5: SSL Certificate**
- **Module:** `modules/ssl-certificate/`
- **Creates:** ACM certificate, DNS validation records
- **Dependencies:** Domain ownership, Route53 hosted zone
- **Status:** 📋 Planned
- **⏱️ Time:** 5-10 minutes for validation

#### **Step 6: Application Load Balancer** ⬅️ **CURRENT STEP**
- **Module:** `modules/alb/`
- **Creates:** ALB, target groups, HTTP/HTTPS listeners, subdomain A record
- **Dependencies:** VPC, security groups, SSL certificate
- **Status:** 📋 Planned

---

### **PHASE 3: APPLICATION & DATABASE** 🔄

#### **Step 7: ECS Cluster & Service**
- **Module:** `modules/ecs/` (to be created)
- **Creates:** ECS cluster, service, task definition
- **Dependencies:** ALB (target group), IAM roles, security groups
- **Status:** 📋 Planned

#### **Step 8: RDS Database**
- **Module:** `modules/rds/` (to be created)
- **Creates:** RDS instance, subnet group, parameter group
- **Dependencies:** VPC (private subnets), security groups
- **Status:** 📋 Planned

---

## 🛠️ **CURRENT DEPLOYMENT COMMANDS**

### **Deploy ALB Module (Step 6):**

1. **Add ALB module to main.tf:**
```hcl
# Add to scalable-web-platform/main.tf
module "alb" {
  source = "../modules/alb"
  
  project_name           = var.project_name
  vpc_id                 = module.vpc.vpc_id
  public_subnet_az1_id   = module.vpc.public_subnet_az1_id
  public_subnet_az2_id   = module.vpc.public_subnet_az2_id
  alb_security_group_id  = module.security_group.alb_security_group_id
  certificate_arn        = module.ssl_certificate.certificate_arn
  domain_name            = var.domain_name
  hosted_zone_id         = var.hosted_zone_id
}
```

2. **Deploy:**
```bash
cd scalable-web-platform/
terraform init
terraform plan
terraform apply
```

3. **Verify:**
- Check ALB in AWS Console
- Test subdomain: `https://YourProjectName.YourDomainName.com`
- Should show ALB default page (503 error is normal -  if no targets yet)

---

## 📁 **PROJECT STRUCTURE**

```
test-terraform/
├── modules/
│   ├── vpc/                    ✅ VPC & networking
│   ├── nat-gateway/           ✅ NAT gateways
│   ├── security-groups/       ✅ Security groups
│   ├── iam-roles/            ✅ ECS IAM roles
│   ├── ssl-certificate/      ✅ SSL certificate
│   ├── alb/                  🔄 Load balancer 
│   ├── ecs/                  📋 ECS cluster 
│   └── rds/                  📋 Database 
├── scalable-web-platform/
│   ├── main.tf               🔄 Module orchestration
│   ├── variables.tf          ✅ Variable definitions
│   ├── terraform.tfvars      ✅ Variable values
│   └── outputs.tf            📋 Output definitions
└── terraform-modules-guide.html  📚 Learning resource
```

---

## 🔧 **TERRAFORM.IO REFERENCE GUIDE**

### **How to Find Examples:**
1. Go to: https://registry.terraform.io/
2. Search: "hashicorp/aws"
3. Click: "hashicorp/aws" provider
4. Use left sidebar to navigate to resources
5. Each resource page has "Example Usage" section

### **Key Resources by Module:**
- **VPC:** `aws_vpc`, `aws_subnet`, `aws_internet_gateway`, `aws_route_table`
- **NAT:** `aws_eip`, `aws_nat_gateway`
- **Security:** `aws_security_group`, `aws_vpc_security_group_ingress_rule`
- **IAM:** `aws_iam_role`, `aws_iam_role_policy_attachment`
- **SSL:** `aws_acm_certificate`, `aws_acm_certificate_validation`
- **ALB:** `aws_lb`, `aws_lb_target_group`, `aws_lb_listener`
- **ECS:** `aws_ecs_cluster`, `aws_ecs_service`, `aws_ecs_task_definition`
- **RDS:** `aws_db_instance`, `aws_db_subnet_group`

---

## 🎯 **NEXT STEPS AFTER ALB**

1. **Test ALB deployment**
2. **Create ECS module** for containerized applications
3. **Create RDS module** for database
4. **Deploy complete stack**
5. **Configure application deployment pipeline**

---

## 🔍 **TROUBLESHOOTING**

### **Common Issues:**
- **SSL validation timeout:** Check Route53 hosted zone permissions
- **ALB 503 errors:** Normal until ECS targets are registered
- **Security group issues:** Verify port 80/443 rules
- **DNS propagation:** Can take up to 48 hours globally

### **Useful Commands:**
```bash
# Check SSL certificate status
aws acm describe-certificate --certificate-arn <cert-arn>

# Check ALB health
aws elbv2 describe-load-balancers --names scalable-web-app-alb

# Check target group health
aws elbv2 describe-target-health --target-group-arn <tg-arn>
```

---

## 📊 **DEPLOYMENT PROGRESS**

- [x] **Phase 1:** Foundation Infrastructure (100%)
- [x] **Phase 2:** SSL & Load Balancer (50% - ALB pending)
- [ ] **Phase 3:** Application & Database (0%)

**Current Status:** pending (Step 6)

---

*This README will be updated as each component is deployed. Keep this as your deployment guide!*