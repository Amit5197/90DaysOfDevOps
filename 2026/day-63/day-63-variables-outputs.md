# Day 63 -- Variables, Outputs, Data Sources and Expressions

## Task
Your Day 62 config works, but it is full of hardcoded values -- region, CIDR blocks, AMI IDs, instance types, tags. Change the region and everything breaks. Today you make your Terraform configs dynamic, reusable, and environment-aware.

This is the difference between a config that works once and a config you can use across projects.

---

## Challenge Tasks

### Task 1: Extract Variables
Take your Day 62 infrastructure config and refactor it:

1. Create a `variables.tf` file with input variables for:
   - `region` (string, default: your preferred region)
   - `vpc_cidr` (string, default: `"10.0.0.0/16"`)
   - `subnet_cidr` (string, default: `"10.0.1.0/24"`)
   - `instance_type` (string, default: `"t2.micro"`)
   - `project_name` (string, no default -- force the user to provide it)
   - `environment` (string, default: `"dev"`)
   - `allowed_ports` (list of numbers, default: `[22, 80, 443]`)
   - `extra_tags` (map of strings, default: `{}`)

2. Replace every hardcoded value in `main.tf` with `var.<name>` references
3. Run `terraform plan` -- it should prompt you for `project_name` since it has no default

**Document:** What are the five variable types in Terraform? (`string`, `number`, `bool`, `list`, `map`)

- `string` names or any text
   ```bash
   variable "instance_name" {
   type    = string
   default = "my-ec2"
   }

   # Usage in resource
   tags = { Name = var.instance_name }
   ```
- `number` counts
   ```bash
      variable "instance_count" {
      type    = number
      default = 2
      }

      # Usage in resource
      count = var.instance_count
   ```

- `bool` conditional true or false
   ```bash
      variable "assign_public_ip" {
      type    = bool
      default = true
      }

      # Usage in resource
      associate_public_ip_address = var.assign_public_ip
   ```

- `list` Ordered collection
   ```bash
      variable "security_groups" {
      type    = list(string)
      default = ["sg-123", "sg-456"]
      }

      # Usage in resource
      vpc_security_group_ids = var.security_groups
   ```
- `map` Key-value pairs
   ```bash
      variable "s3_buckets" {
      type = map(string)
      default = {
         bucket1 = "us-east-1"
         bucket2 = "us-west-2"
         }
      }

      # Usage in resource
      for_each = var.s3_buckets
      bucket   = each.key
      region   = each.value
   ```
   
---

### Task 2: Variable Files and Precedence
1. Create `terraform.tfvars`:
```hcl
project_name = "terraweek"
environment  = "dev"
instance_type = "t2.micro"
```

2. Create `prod.tfvars`:
```hcl
project_name = "terraweek"
environment  = "prod"
instance_type = "t3.small"
vpc_cidr     = "10.1.0.0/16"
subnet_cidr  = "10.1.1.0/24"
```


3. Apply with the default file:
```bash
terraform plan                              # Uses terraform.tfvars automatically
```

<img width="812" height="980" alt="image" src="https://github.com/user-attachments/assets/35ab84d9-1845-42b6-9a0e-8d98c59ce38c" />

- terraform.tfvars is automatically loaded by default

4. Apply with the prod file:
```bash
terraform plan -var-file="prod.tfvars"      # Uses prod.tfvars
```

<img width="676" height="746" alt="image" src="https://github.com/user-attachments/assets/e61cf1c6-f3b3-4c54-9f91-4f958223d24c" />

<img width="835" height="761" alt="image" src="https://github.com/user-attachments/assets/affc154d-106f-4ec7-b9a5-bceb64aee3f3" />

5. Override with CLI:
```bash
terraform plan -var="instance_type=t2.nano"  # CLI overrides everything
```

<img width="1356" height="990" alt="image" src="https://github.com/user-attachments/assets/021e56cb-9296-4629-aa50-f47338619791" />

6. Set an environment variable:
```bash
export TF_VAR_environment="staging"
terraform plan                              # env var overrides default but not tfvars
```

<img width="1317" height="982" alt="image" src="https://github.com/user-attachments/assets/1060352d-8fa2-4d9e-a54c-ad80991fdbf7" />

- `export TF_VAR_environment="staging"` overrides only the `default` in variables.tf, but does not override `terraform.tfvars`.
- `terraform.tfvars` have `environment = dev`, Terraform uses `"dev"`

**Document:** Write the variable precedence order from lowest to highest priority.

1. **Default value** in the `variable` block (`variables.tf`)
2. **`terraform.tfvars`** or other `.tfvars` / `.auto.tfvars` files
3. **Environment variable** (`TF_VAR_<variable_name>`)
4. **CLI `-var` flag** 

- So the **highest priority** is the CLI `-var`, and the **lowest** is the default in `variables.tf`.

---

### Task 3: Add Outputs
Create an `outputs.tf` file with outputs for:

1. `vpc_id` -- the VPC ID
2. `subnet_id` -- the public subnet ID
3. `instance_id` -- the EC2 instance ID
4. `instance_public_ip` -- the public IP of the EC2 instance
5. `instance_public_dns` -- the public DNS name
6. `security_group_id` -- the security group ID

Apply your config and verify the outputs are printed at the end:
```bash
terraform apply

# After apply, you can also run:
terraform output                          # Show all outputs
terraform output instance_public_ip       # Show a specific output
terraform output -json                    # JSON format for scripting
```

<img width="1117" height="447" alt="image" src="https://github.com/user-attachments/assets/265891d0-74aa-4cd8-8abf-3c224ca1b309" />

<img width="1025" height="575" alt="image" src="https://github.com/user-attachments/assets/51dd0e5a-a6a8-48f1-9159-9bbf8d6b8722" />

**Verify:** Does `terraform output instance_public_ip` return the correct IP?

- Yes

<img width="1912" height="741" alt="image" src="https://github.com/user-attachments/assets/a1778fdd-b4da-41af-97ea-4f6c5ddf1881" />

---

### Task 4: Use Data Sources
Stop hardcoding the AMI ID. Use a data source to fetch it dynamically.

1. Add a `data "aws_ami"` block that:
   - Filters for Amazon Linux 2 images
   - Filters for `hvm` virtualization and `gp2` root device
   - Uses `owners = ["amazon"]`
   - Sets `most_recent = true`

2. Replace the hardcoded AMI in your `aws_instance` with `data.aws_ami.amazon_linux.id`

3. Add a `data "aws_availability_zones"` block to fetch available AZs in your region

4. Use the first AZ in your subnet: `data.aws_availability_zones.available.names[0]`

Apply and verify -- your config now works in any region without changing the AMI.

<img width="1816" height="830" alt="image" src="https://github.com/user-attachments/assets/5883e12e-16a9-4f70-8e6e-0c333fef2ee7" />

**Document:** What is the difference between a `resource` and a `data` source?

   | Feature           | `resource`           | `data`                        |
   | ----------------- | -------------------- | ----------------------------- |
   | Creates infra     |   Yes                |    No                          |
   | Managed by TF     |   Yes                |    No                          |
   | Stored in state   |   Yes                |     Read-only reference        |
   | Lifecycle actions | create/update/delete | read-only                     |
   | Use case          | EC2, VPC, Subnet     | AMI lookup, AZs, existing VPC |

---

### Task 5: Use Locals for Dynamic Values
1. Add a `locals` block:
```hcl
locals {
  name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
```

2. Replace all Name tags with `local.name_prefix`:
   - VPC: `"${local.name_prefix}-vpc"`
   - Subnet: `"${local.name_prefix}-subnet"`
   - Instance: `"${local.name_prefix}-server"`

3. Merge common tags with resource-specific tags:
```hcl
tags = merge(local.common_tags, {
  Name = "${local.name_prefix}-server"
})
```

Apply and check the tags in the AWS console -- every resource should have consistent tagging.

<img width="1811" height="855" alt="image" src="https://github.com/user-attachments/assets/4834e46a-8a41-41bf-814e-e8766992d914" />

<img width="1796" height="905" alt="image" src="https://github.com/user-attachments/assets/32574708-1f9c-455a-9321-53a915836f89" />

---

### Task 6: Built-in Functions and Conditional Expressions
Practice these in `terraform console`:
```bash
terraform console
```

1. **String functions:**
   - `upper("terraweek")` -> `"TERRAWEEK"`
   - `join("-", ["terra", "week", "2026"])` -> `"terra-week-2026"`
   - `format("arn:aws:s3:::%s", "my-bucket")`

2. **Collection functions:**
   - `length(["a", "b", "c"])` -> `3`
   - `lookup({dev = "t2.micro", prod = "t3.small"}, "dev")` -> `"t2.micro"`
   - `toset(["a", "b", "a"])` -> removes duplicates

3. **Networking function:**
   - `cidrsubnet("10.0.0.0/16", 8, 1)` -> `"10.0.1.0/24"`

4. **Conditional expression** -- add this to your config:
```hcl
instance_type = var.environment == "prod" ? "t3.small" : "t2.micro"
```

Apply with `environment = "prod"` and verify the instance type changes.

<img width="1040" height="317" alt="image" src="https://github.com/user-attachments/assets/54c18f83-2028-4dc6-8ce7-12beabe94324" />

<img width="1686" height="792" alt="image" src="https://github.com/user-attachments/assets/a850aa2d-bf59-41bc-ad5c-6866f57667b1" />

**Document:** Pick five functions you find most useful and explain what each does.

   - `upper()` used for string formatting
      - upper(var.environment)   `"dev" → "DEV"`
   - `join()`  used to combine values
      - join("-", ["app", var.environment, "2026"])   `"app-dev-2026"`
   - `format()` used to build structured strings (like ARNs)
      - format("arn:aws:s3:::%s", my-bucket) `"arn:aws:s3:::my-bucket"`
   - `lookup()` used for environment-based selection
      - lookup({dev = "t2.micro", prod = "t3.small"}, "dev") `"t2.micro"`
   - `cidrsubnet()` used for network/subnet creation
      - cidrsubnet("10.0.0.0/16", 8, 1)  `creates "10.0.1.0/24"`

---

**Explanation of variable precedence with examples**

| Priority (High → Low) | Source                     | Example                                    |  Value       |
| --------------------- | -------------------------- | ------------------------------------------ | ------------ |
| 1 (Highest)           | Command-line (`-var`)      | `terraform plan -var="environment=qa"`     | `qa`         |
| 2                     | Command-line (`-var-file`) | `terraform plan -var-file="prod.tfvars"`   | `prod`       |
| 3                     | Auto-loaded tfvars         | `terraform.tfvars → environment = "stage"` | `stage`      |
| 4                     | Environment variable       | `TF_VAR_environment=uat`                   | `uat`        |
| 5 (Lowest)            | Default value              | `default = "dev"`                          | `dev`        |


**The difference between `variable`, `local`, `output`, and `data`**

   `variable:` Used to take input values from the user.

   `local:` Used to define internal reusable values or expressions.
   
   `data:` Used to fetch existing resources from the provider (read-only).
   
   `output:` Used to display or export values after execution.

---

`#90DaysOfDevOps` `#TerraWeek` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
