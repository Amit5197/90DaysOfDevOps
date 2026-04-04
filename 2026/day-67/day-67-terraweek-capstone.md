# Day 67 -- TerraWeek Capstone: Multi-Environment Infrastructure with Workspaces and Modules

## Challenge Tasks

### Task 1: Learn Terraform Workspaces
Before building the project, understand workspaces:

```bash
mkdir terraweek-capstone && cd terraweek-capstone
terraform init

# See current workspace
terraform workspace show                    # default

![image](images/showws.png)

# Create new workspaces
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod

![image](images/newws.png)

# List all workspaces
terraform workspace list

![image](images/listws.png)

# Switch between them
terraform workspace select dev
terraform workspace select staging
terraform workspace select prod
```
![image](images/switchws.png)

Answer:
1. What does `terraform.workspace` return inside a config?
- `terraform.workspace` is a built-in variable that returns the name of the currently selected workspace.

2. Where does each workspace store its state file?
- In `terraform.tfstate.d` directory

3. How is this different from using separate directories per environment?
- `Workspaces:` One codebase, multiple environments via separate state files
- `Directories:` Multiple copies of code, one per environment
---

### Task 2: Set Up the Project Structure
Create this layout:

```
terraweek-capstone/
  main.tf                   # Root module -- calls child modules
  variables.tf              # Root variables
  outputs.tf                # Root outputs
  providers.tf              # AWS provider and backend
  locals.tf                 # Local values using workspace
  dev.tfvars                # Dev environment values
  staging.tfvars            # Staging environment values
  prod.tfvars               # Prod environment values
  .gitignore                # Ignore state, .terraform, tfvars with secrets
  modules/
    vpc/
      main.tf
      variables.tf
      outputs.tf
    security-group/
      main.tf
      variables.tf
      outputs.tf
    ec2-instance/
      main.tf
      variables.tf
      outputs.tf
```

Create the `.gitignore`:
```
.terraform/
*.tfstate
*.tfstate.backup
*.tfvars
.terraform.lock.hcl
```

**Document:** Why is this file structure considered best practice?
- This Terraform structure is best practice because it keeps everything clean and easy to manage.
- We separate files `main.tf` `variables.tf`and `outputs.tf` so the code is more organized and easier to understand.
- We use modules, which helps us reuse code instead of writing the same thing again and again.
- We also support different environments like `dev` `staging` and `prod` using `.tfvars` files, which makes deployment safer.
- The `.gitignore` file protects sensitive data like state files and secrets.
- Overall, this structure makes the project organized, reusable and secure which is important for real-world use.
---

### Task 3: Build the Custom Modules
Create three focused modules:

**Module 1: `modules/vpc/`**
- Input: `cidr`, `public_subnet_cidr`, `environment`, `project_name`
- Resources: VPC, public subnet, internet gateway, route table, route table association
- Output: `vpc_id`, `subnet_id`
- All resources tagged with environment and project name

**Module 2: `modules/security-group/`**
- Input: `vpc_id`, `ingress_ports`, `environment`, `project_name`
- Resources: Security group with dynamic ingress rules, allow all egress
- Output: `sg_id`

**Module 3: `modules/ec2-instance/`**
- Input: `ami_id`, `instance_type`, `subnet_id`, `security_group_ids`, `environment`, `project_name`
- Resources: EC2 instance with tags
- Output: `instance_id`, `public_ip`

Write and validate each module:
```bash
terraform validate
```

![image](images/task3.png)
---

### Task 4: Wire It All Together with Workspace-Aware Config
In the root module, use `terraform.workspace` to drive environment-specific behavior.

**`locals.tf`:**
```hcl
locals {
  environment = terraform.workspace
  name_prefix = "${var.project_name}-${local.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = local.environment
    ManagedBy   = "Terraform"
    Workspace   = terraform.workspace
  }
}
```

**`variables.tf`:**
```hcl
variable "project_name" {
  type    = string
  default = "terraweek"
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ingress_ports" {
  type    = list(number)
  default = [22, 80]
}
```

**`main.tf`** -- call all three modules, passing workspace-aware names and variables.

**Environment-specific tfvars:**

`dev.tfvars`:
```hcl
vpc_cidr      = "10.0.0.0/16"
subnet_cidr   = "10.0.1.0/24"
instance_type = "t3.micro"  # Im taking here `t3.micro`,`t2.micro` is not available in my AWS account
```

`staging.tfvars`:
```hcl
vpc_cidr      = "10.1.0.0/16"
subnet_cidr   = "10.1.1.0/24"
instance_type = "t3.small" 
ingress_ports = [22, 80, 443]
```

`prod.tfvars`:
```hcl
vpc_cidr      = "10.2.0.0/16"
subnet_cidr   = "10.2.1.0/24"
instance_type = "c7i-flex.large"  # Im taking here c7i-flex.large
ingress_ports = [80, 443]
```

Notice: dev allows SSH, prod does not. Different CIDRs prevent overlap. Instance types scale up per environment.

---

### Task 5: Deploy All Three Environments
Deploy each environment using its workspace and tfvars file:

**Dev:**
```bash
terraform workspace select dev
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

**Staging:**
```bash
terraform workspace select staging
terraform plan -var-file="staging.tfvars"
terraform apply -var-file="staging.tfvars"
```

**Prod:**
```bash
terraform workspace select prod
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```
![image](images/task5_apply.png)

After all three are deployed, verify:
```bash
# Check each workspace's resources
terraform workspace select dev && terraform output
terraform workspace select staging && terraform output
terraform workspace select prod && terraform output
```

![image](images/terraform_outputs.png)

Go to the AWS console and verify:
- Three separate VPCs with different CIDR ranges
- Three EC2 instances with different instance types
- Different Name tags per environment: `terraweek-dev-server`, `terraweek-staging-server`, `terraweek-prod-server`

**Verify:** Are all three environments completely isolated from each other?

![image](images/infra_console.png)

---

### Task 6: Terraform best practices guide:
 
1. **File Structure** — Separate files for each concern: `providers.tf`, `variables.tf`, `outputs.tf`, `locals.tf`, `main.tf`
2. **State Management** — Remote S3 backend with `encrypt = true`, `use_lockfile = true`. Each workspace gets its own state file at `env:/<workspace>/terraweek-capstone/terraform.tfstate`
3. **Variables** — Never hardcode values. Used `dev/staging/prod.tfvars` per environment.
4. **Modules** — One concern per module. Three focused modules: `vpc/` (networking), `security-group/` (access control), `ec2-instance/` (compute). Each module has `main.tf`, `variables.tf`, `outputs.tf`
5. **Workspaces** — Three workspaces for full environment isolation. `terraform.workspace` drives environment name through `locals.tf`. One codebase, three environments
6. **Security** — `.gitignore` excludes `*.tfvars`, `*.tfstate`, `.terraform/`. State encrypted at rest with `encrypt = true`. No credentials hardcoded anywhere
7. **Commands** — Always `terraform validate` → `terraform plan` → `terraform apply`. Never skip plan. Use `terraform fmt` before committing
8. **Tagging** — Every resource tagged with `Environment`, `Project`, `ManagedBy = "Terraform"`.
9. **Naming** — Consistent pattern: `<environment>-<project>-<resource>` e.g. `dev-terraweek-VPC`, `terraweek-prod-Server`
10. **Cleanup** — always `terraform destroy` non-production environments when not in use

---

### Task 7: Destroy All Environments
Clean up all three environments in reverse order:

```bash
terraform workspace select prod
terraform destroy -var-file="prod.tfvars"

terraform workspace select staging
terraform destroy -var-file="staging.tfvars"

terraform workspace select dev
terraform destroy -var-file="dev.tfvars"
```
![image](images/terraform_destroy.png)

Verify in the AWS console -- all VPCs, instances, security groups, and gateways should be gone.

![image](images/aws_console_verify.png)

Delete the workspaces:
```bash
terraform workspace select default
terraform workspace delete dev
terraform workspace delete staging
terraform workspace delete prod
```
![image](images/ws_delete.png)

**Verify:** Is your AWS account completely clean?
- Yes
---

## Complete Project Structure

```
terraweek-capstone/
├── main.tf                    # Root module — calls all 3 child modules
├── variables.tf               # Input variables with validation blocks
├── outputs.tf                 # Root outputs (vpc_id, subnet_id, sg_id, instance_id, public_ip)
├── providers.tf               # AWS provider + S3 remote backend
├── locals.tf                  # Workspace-aware locals (environment, name_prefix, common_tags)
├── dev.tfvars                 # Dev environment values
├── staging.tfvars             # Staging environment values
├── prod.tfvars                # Prod environment values
├── .gitignore                 # Ignores .terraform/, *.tfstate, *.tfvars
├── modules/
    ├── vpc/
    │   ├── main.tf            # aws_vpc, aws_subnet, aws_internet_gateway, aws_route_table, aws_route_table_association
    │   ├── variables.tf       # cidr, public_subnet_cidr, environment, project_name
    │   └── outputs.tf         # vpc_id, subnet_id
    ├── security-group/
    │   ├── main.tf            # aws_security_group — dynamic ingress + allow-all egress
    │   ├── variables.tf       # vpc_id, ingress_ports, environment, project_name
    │   └── outputs.tf         # sg_id
    └── ec2-instance/
        ├── main.tf            # aws_instance with environment tags
        ├── variables.tf       # ami_id, instance_type, subnet_id, security_group_ids, environment, project_name
        └── outputs.tf         # instance_id, public_ip
```

---

## Module 1 — `modules/vpc/`

### `variables.tf`
```hcl
variable "cidr"               { type = string }
variable "public_subnet_cidr" { type = string }
variable "environment"        { type = string }
variable "project_name"       { type = string }
```

### `main.tf`
```hcl
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "${var.environment}-${var.project_name}-VPC"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.environment}-${var.project_name}-Public-Subnet"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-${var.project_name}-Internet-Gateway"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name        = "${var.environment}-${var.project_name}-Public-Route-Table"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
```

### `outputs.tf`
```hcl
output "vpc_id"    { value = aws_vpc.vpc.id }
output "subnet_id" { value = aws_subnet.public_subnet.id }
```

---

## Module 2 — `modules/security-group/`

### `variables.tf`
```hcl
variable "vpc_id"        { type = string }
variable "ingress_ports" { type = list(number) }
variable "environment"   { type = string }
variable "project_name"  { type = string }
```

### `main.tf`
```hcl
resource "aws_security_group" "sg" {
  name        = "${var.project_name}-${var.environment}-SG"
  description = "Security group with dynamic allowed ports"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-Sg"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}
```

### `outputs.tf`
```hcl
output "sg_id" { value = aws_security_group.sg.id }
```

---

## Module 3 — `modules/ec2-instance/`

### `variables.tf`
```hcl
variable "ami_id"             { type = string }
variable "instance_type"      { type = string }
variable "subnet_id"          { type = string }
variable "security_group_ids" { type = list(string) }
variable "environment"        { type = string }
variable "project_name"       { type = string }
```

### `main.tf`
```hcl
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name        = "${var.project_name}-${var.environment}-Server"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}
```

### `outputs.tf`
```hcl
output "instance_id" { value = aws_instance.ec2_instance.id }
output "public_ip"   { value = aws_instance.ec2_instance.public_ip }
```

---

## Root `main.tf` — Workspace-Aware Module Calls

```hcl
# Data source — auto-fetch latest Amazon Linux 2 AMI (no hardcoding)
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter { name = "name"               values = ["amzn2-ami-hvm-*-x86_64-*"] }
  filter { name = "virtualization-type" values = ["hvm"] }
  filter { name = "architecture"       values = ["x86_64"] }
  filter { name = "root-device-type"   values = ["ebs"] }
}

# Module 1 — VPC (environment driven by terraform.workspace via locals)
module "vpc" {
  source             = "./modules/vpc"
  cidr               = var.vpc_cidr
  public_subnet_cidr = var.subnet_cidr
  environment        = local.environment   # "dev" / "staging" / "prod"
  project_name       = var.project_name
}

# Module 2 — Security Group (receives vpc_id from module.vpc output)
module "security_group" {
  source        = "./modules/security-group"
  vpc_id        = module.vpc.vpc_id
  ingress_ports = var.ingress_ports
  environment   = local.environment
  project_name  = var.project_name
}

# Module 3 — EC2 Instance (receives AMI, subnet, SG from other modules/data)
module "ec2" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.amazon_linux_2.id
  instance_type      = var.instance_type
  subnet_id          = module.vpc.subnet_id
  security_group_ids = [module.security_group.sg_id]
  environment        = local.environment
  project_name       = var.project_name
}
```

---

## Three tfvars Files — Differences Highlighted

```hcl
# ── dev.tfvars ─────────────────────────────────────
vpc_cidr      = "10.0.0.0/16"
subnet_cidr   = "10.0.1.0/24"
instance_type = "t3.micro"          
ingress_ports = [22, 80]            # SSH allowed for development

# ── staging.tfvars ─────────────────────────────────
vpc_cidr      = "10.1.0.0/16"      # different CIDR — no overlap with dev
subnet_cidr   = "10.1.1.0/24"
instance_type = "t3.small"          
ingress_ports = [22, 80, 443]       # HTTPS added for staging tests

# ── prod.tfvars ────────────────────────────────────
vpc_cidr      = "10.2.0.0/16"      # different CIDR — no overlap with dev/staging
subnet_cidr   = "10.2.1.0/24"
instance_type = "c7i-flex.large"    
ingress_ports = [80, 443]           # NO SSH in prod — security hardened
```

| Setting | `dev` | `staging` | `prod` |
|---------|-------|-----------|--------|
| `vpc_cidr` | `10.0.0.0/16` | `10.1.0.0/16` | `10.2.0.0/16` |
| `subnet_cidr` | `10.0.1.0/24` | `10.1.1.0/24` | `10.2.1.0/24` |
| `instance_type` | `t3.micro` | `t3.small` | `c7i-flex.large` |
| `ingress_ports` | `[22, 80]` | `[22, 80, 443]` | `[80, 443]` |
| SSH (port 22) |  Yes |  Yes |  No |
| HTTPS (port 443) |  No |  Yes |  Yes |

---

## TerraWeek Day-by-Day Concepts

| Day | Concepts |
|-----|----------|
| 61 | IaC, HCL, init/plan/apply/destroy, state basics |
| 62 | Providers, resources, dependencies, lifecycle |
| 63 | Variables, outputs, data sources, locals, functions |
| 64 | Remote backend, locking, import, drift |
| 65 | Custom modules, registry modules, versioning |
| 66 | EKS with modules, real-world provisioning |
| 67 | Workspaces, multi-env, capstone project |