# Security Group Module

A reusable Terraform module that creates an AWS Security Group with **dynamic ingress rules** based on a list of ports, and a permissive egress rule for all outbound traffic.

---

## Module Structure

```
modules/security-group/
├── main.tf        # Security group resource with dynamic ingress block
├── variables.tf   # Input variable declarations
├── outputs.tf     # Output value declarations
└── README.md      
```

---

## Resources Created

| Resource | Type | Description |
|---|---|---|
| `aws_security_group.sg` | `aws_security_group` | A security group with dynamic TCP ingress rules |

---

## Usage

Call this module from your root `main.tf`:

```hcl
module "web_sg" {
  source = "./modules/security-group"

  vpc_id        = module.vpc.vpc_id
  sg_name       = "terraweek-web-sg"
  ingress_ports = [22, 80, 443]

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
| `vpc_id` | `string` | — | Yes | ID of the VPC where the security group will be created |
| `sg_name` | `string` | — | Yes | Name for the security group (also used as the `Name` tag) |
| `ingress_ports` | `list(number)` | `[22, 80, 443]` | No | List of TCP ports to open for inbound traffic |
| `tags` | `map(string)` | `{}` | No | Additional tags to merge onto the security group |

---

## Outputs (outputs.tf)

| Name | Description |
|---|---|
| `sg_id` | The ID of the created security group |

Reference the output from the root module like:

```hcl
module.web_sg.sg_id
```

Pass it into the EC2 module:

```hcl
security_group_ids = [module.web_sg.sg_id]
```

---

## How It Works (main.tf)

The module uses a `dynamic` block to iterate over `ingress_ports` and generate one ingress rule per port:

```hcl
resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = "Security group with dynamic allowed ports"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      description = "Allow Inbound"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    { Name = var.sg_name }
  )
}
```

### Key Points

| Feature | Detail |
|---|---|
| **Dynamic ingress** | Each port in `ingress_ports` becomes its own TCP inbound rule — no hardcoded rules |
| **CIDR** | All ingress rules allow traffic from `0.0.0.0/0` (open to the internet) |
| **Egress** | All outbound traffic is allowed (`protocol = "-1"`) |
| **Tagging** | `Name` tag is always set from `sg_name`; additional tags are merged in |

---