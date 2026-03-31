# Day 63 -- Variables, Outputs, Data Sources and Expressions

## Task 1: Extract Variables
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

   ![snapshot](images/1.png)

**Document:** What are the five variable types in Terraform? (`string`, `number`, `bool`, `list`, `map`)
* `string` : a sequence of Unicode characters representing some text, like `"hello"`.
* `number` : a numeric value. The number type can represent both whole numbers like `15` and fractional values like `6.283185`.
* `bool` : a boolean value, either `true` or `false`. bool values can be used in conditional logic.
* `list` : a sequence of values, like ["us-west-1a", "us-west-1c"]. Identify elements in a list with consecutive whole numbers, starting with zero.
* `map` :  a group of values identified by named labels, like {name = "Mabel", age = 52}.

---

## Task 2: Variable Files and Precedence
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

   ![snapshot](images/2-a.png)

   ![snapshot](images/2-b.png)

4. Apply with the prod file:
```bash
terraform plan -var-file="prod.tfvars"      # Uses prod.tfvars
```

   ![snapshot](images/2-c.png)

   ![snapshot](images/2-d.png)

5. Override with CLI:
```bash
terraform plan -var="instance_type=t2.nano"  # CLI overrides everything
```

   ![snapshot](images/2-e.png)

6. Set an environment variable:
```bash
export TF_VAR_environment="staging"
terraform plan                              # env var overrides default but not tfvars
```

   ![snapshot](images/2-f.png)

**Document:** Write the variable precedence order from lowest to highest priority.
  Variable precedence (low to high): default -> `TF_VAR_*` env vars -> `terraform.tfvars` -> `*.auto.tfvars` -> `-var-file` -> `-var` flag  -> CLI prompts (interactive input)

---

## Task 3: Add Outputs
Create an `outputs.tf` file with outputs for:

1. `vpc_id` -- the VPC ID
2. `subnet_id` -- the public subnet ID
3. `instance_id` -- the EC2 instance ID
4. `instance_public_ip` -- the public IP of the EC2 instance
5. `instance_public_dns` -- the public DNS name
6. `security_group_id` -- the security group ID

Apply your config and verify the outputs are printed at the end:

terraform apply

   ![snapshot](images/3-a.png)

# After apply, you can also run:
terraform output                          # Show all outputs

   ![snapshot](images/3-b.png)

terraform output instance_public_ip       # Show a specific output

   ![snapshot](images/3-c.png)

terraform output -json                    # JSON format for scripting

   ![snapshot](images/3-d.png)


**Verify:** Does `terraform output instance_public_ip` return the correct IP? **YES**

   ![snapshot](images/3-e.png)

---

## Task 4: Use Data Sources
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

**Document:** What is the difference between a `resource` and a `data` source?
   - A `resource` block creates a resource.
   - A `data` block doesn't create resource. It fetches data to be used in `resource`
     block.
---

## Task 5: Use Locals for Dynamic Values
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

   ![snapshot](images/5-a.png)

   ![snapshot](images/5-b.png)

   ![snapshot](images/5-c.png)

   ![snapshot](images/5-d.png)
   
   ![snapshot](images/5-e.png)

   ![snapshot](images/5-f.png)

   ![snapshot](images/5-g.png)

---

## Task 6: Built-in Functions and Conditional Expressions
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

   ![snapshot](images/6-a.png)

4. **Conditional expression** -- add this to your config:
```hcl
instance_type = var.environment == "prod" ? "t3.small" : "t2.micro"
```

Apply with `environment = "prod"` and verify the instance type changes.

   ![snapshot](images/6-b.png)

---

- Five built-in functions you found most useful
   - `format("arn:aws:s3:::%s", "my-bucket")`
      - Replaces %s with string "my-bucket", useful while creating dynamic names.
   - `lookup({dev = "t2.micro", prod = "t3.small"}, "dev")` -> `"t2.micro"`
      - Retrieves a value from a map by key.
   - `cidrsubnet("10.0.0.0/16", 8, 1)` -> `"10.0.1.0/24"`
      - Derives subnet CIDRs from a larger block. Useful for dynamic subnet cidr assignment.
   - `length(["a", "b", "c"])` -> `3`
      - Returns the number of elements in a list.
   - `join("-", ["terra", "week", "2026"])` -> `"terra-week-2026"`
      - Concatenates list items into a single string with a delimiter.

- The difference between `variable`, `local`, `output`, and `data`
   - `variable` - Vakues provided externally. (CLI, tfvars)
   - `local` - Reusable block inside script.
   - `output` - Values exposed after apllying script.
   - `data` - Fetches existing values from provider.

---

