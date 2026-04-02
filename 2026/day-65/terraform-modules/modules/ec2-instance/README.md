# EC2 Instance Module

A reusable Terraform module that provisions an AWS EC2 instance with support for dynamic tagging and security group attachment.

---

## Module Structure

```
modules/ec2-instance/
├── main.tf        # EC2 instance resource definition
├── variables.tf   # Input variable declarations
├── outputs.tf     # Output value declarations
└── README.md      
```

---

## Resources Created

| Resource | Type | Description |
|---|---|---|
| `aws_instance.ec2` | `aws_instance` | A single EC2 instance with a public IP |

---

## Usage

Call this module from your root `main.tf`:

```hcl
module "web_server" {
  source = "./modules/ec2-instance"

  ami_id             = data.aws_ami.amazon_linux_2.id
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraweek-web"

  tags = {
    Owner     = "Your Name"
    ManagedBy = "Terraform"
  }
}
```

---

## Variables (variables.tf)

| Name | Type | Default | Required | Description |
|---|---|---|---|---|
| `ami_id` | `string` | — | Yes | AMI ID for the EC2 instance |
| `instance_type` | `string` | `"t3.micro"` | No | EC2 instance type |
| `subnet_id` | `string` | — | Yes | Subnet ID where the instance will be placed |
| `security_group_ids` | `list(string)` | — | Yes | List of security group IDs to attach |
| `instance_name` | `string` | — | Yes | Name tag for the EC2 instance |
| `tags` | `map(string)` | `{}` | No | Additional tags to merge onto the instance |

---

## Outputs (outputs.tf)

| Name | Description |
|---|---|
| `instance_id` | The ID of the created EC2 instance |
| `public_ip` | Public IP address of the EC2 instance |
| `private_ip` | Private IP address of the EC2 instance |

Reference outputs from root like:

```hcl
module.web_server.public_ip
module.web_server.instance_id
```

---

## How It Works (main.tf)

The module creates a single `aws_instance` resource:

- Uses the provided `ami_id` and `instance_type`.
- Places the instance in `subnet_id` with `associate_public_ip_address = true`.
- Attaches the provided `security_group_ids` using VPC security groups.
- Applies tags by **merging** the `Name` tag derived from `instance_name` with any custom `tags` passed in.

```hcl
resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true

  tags = merge(
    { Name = var.instance_name },
    var.tags
  )
}
```

---