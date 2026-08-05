# Day 67 -- TerraWeek Capstone: Multi-Environment Infrastructure with Workspaces and Modules

## Task
Seven days of Terraform -- HCL, providers, resources, dependencies, variables, outputs, data sources, state management, remote backends, custom modules, registry modules, and a full EKS cluster. Today you put it all together in one production-grade project.

Build a multi-environment AWS infrastructure using custom modules and Terraform workspaces. One codebase, three environments -- dev, staging, and prod. This is how infrastructure teams operate at scale.

---

## Expected Output
- A complete Terraform project with custom modules and proper file structure
- Three separate environments (dev, staging, prod) deployed using workspaces
- Each environment with its own VPC, security group, and EC2 instance with different sizing
- A markdown file: `day-67-terraweek-capstone.md`
- Everything destroyed cleanly after verification

---

## Challenge Tasks

### Task 1: Learn Terraform Workspaces
Before building the project, understand workspaces:

```bash
mkdir terraweek-capstone && cd terraweek-capstone
terraform init

# See current workspace
terraform workspace show                    # default

# Create new workspaces
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod

# List all workspaces
terraform workspace list

# Switch between them
terraform workspace select dev
terraform workspace select staging
terraform workspace select prod
```
1- Create the S3 bucket using AWS CLI:

```aws s3api create-bucket --bucket terraweek-capstone-amit-pandey --region us-east-1```

2- Enable versioning on the bucket (Best Practice for State Files):

```aws s3api put-bucket-versioning --bucket terraweek-capstone-amit-pandey --versioning-configuration Status=Enabled```

3- Re-run initialization:

```terraform init```

<img width="1897" height="887" alt="image" src="https://github.com/user-attachments/assets/e5edef90-0455-447b-bdfe-06f7ef4c22e6" />

<img width="998" height="783" alt="image" src="https://github.com/user-attachments/assets/a0bbd79f-a71d-4175-a86f-26eb3074e16b" />

Answer:
1. What does `terraform.workspace` return inside a config?
 
 - `terraform.workspace` is a built-in variable that returns the name of the currently selected workspace.

- ***Dynamic Resource Naming***

```
resource "aws_s3_bucket" "example" {
  bucket = "my-app-bucket-${terraform.workspace}"
}

# Evaluates to "my-app-bucket-dev", "my-app-bucket-prod", etc.

```

- ***Environment-Based Variable Lookup(Maps)***

```
locals {
  instance_type = {
    dev  = "t3.micro"
    prod = "t3.large"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = local.instance_type[terraform.workspace]
}
```

2. Where does each workspace store its state file?

- In `terraform.tfstate.d` directory

3. How is this different from using separate directories per environment?

`Workspaces`: One codebase, multiple environments via separate state files
`Directories`: Multiple copies of code, one per environment

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

<img width="1002" height="452" alt="image" src="https://github.com/user-attachments/assets/ff02603c-028c-47da-8ceb-18f4d0c7a573" />

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
instance_type = "t2.micro"
ingress_ports = [22, 80]
```

`staging.tfvars`:
```hcl
vpc_cidr      = "10.1.0.0/16"
subnet_cidr   = "10.1.1.0/24"
instance_type = "t2.small"
ingress_ports = [22, 80, 443]
```

`prod.tfvars`:
```hcl
vpc_cidr      = "10.2.0.0/16"
subnet_cidr   = "10.2.1.0/24"
instance_type = "t3.small"
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

After all three are deployed, verify:
```bash
# Check each workspace's resources
terraform workspace select dev && terraform output
terraform workspace select staging && terraform output
terraform workspace select prod && terraform output
```

Go to the AWS console and verify:
- Three separate VPCs with different CIDR ranges
- Three EC2 instances with different instance types
- Different Name tags per environment: `terraweek-dev-server`, `terraweek-staging-server`, `terraweek-prod-server`

**Verify:** Are all three environments completely isolated from each other?

---

### Task 6: Document Best Practices
Write down everything you have learned this week as a Terraform best practices guide:

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

Verify in the AWS console -- all VPCs, instances, security groups, and gateways should be gone.

Delete the workspaces:
```bash
terraform workspace select default
terraform workspace delete dev
terraform workspace delete staging
terraform workspace delete prod
```

**Verify:** Is your AWS account completely clean?

---

## Hints
- Each workspace has its own state file -- `terraform.tfstate.d/<workspace>/terraform.tfstate`
- `terraform.workspace` is a built-in variable available in any config
- You cannot delete a workspace you are currently on -- switch to `default` first
- Different VPC CIDRs per environment prevent accidental peering conflicts
- `terraform plan -var-file` does NOT auto-load `terraform.tfvars` when you specify `-var-file`
- If you forget which workspace you are on: `terraform workspace show`
- Workspaces work with remote backends too -- S3 key becomes `env:/<workspace>/terraform.tfstate`

---

## Documentation
Create `day-67-terraweek-capstone.md` with:
- Your complete project structure (directory tree)

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

- All three custom module configs
- Root `main.tf` showing workspace-aware module calls
- All three tfvars files with the differences highlighted
- Screenshot of all three environments running simultaneously in AWS
- Screenshot of `terraform output` from each workspace
- Your Terraform best practices guide (Task 6)
- A table mapping each TerraWeek day to the concepts learned:

| Day | Concepts |
|-----|----------|
| 61 | IaC, HCL, init/plan/apply/destroy, state basics |
| 62 | Providers, resources, dependencies, lifecycle |
| 63 | Variables, outputs, data sources, locals, functions |
| 64 | Remote backend, locking, import, drift |
| 65 | Custom modules, registry modules, versioning |
| 66 | EKS with modules, real-world provisioning |
| 67 | Workspaces, multi-env, capstone project |

---

## Submission
1. Add `day-67-terraweek-capstone.md` to `2026/day-67/`
2. Commit and push to your fork

---

`#90DaysOfDevOps` `#TerraWeek` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
