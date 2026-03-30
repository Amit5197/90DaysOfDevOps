# Day 61 -- Introduction to Terraform and Your First AWS Infrastructure

## Task 1: Understand Infrastructure as Code
Before touching the terminal, research and write short notes on:

1. What is Infrastructure as Code (IaC)? Why does it matter in DevOps?
   - Iac let's you define resources and infrastructure in human readable, declarative
     configuration files and manages your infrastructure's lifecycle.
   - In simple terms it means managing your infrasturcture through code instead of manual.
   - In DevOps it provides consistency, automation, version control, CI/CD integration,
     reduce errors and is reproducable and scalable.

2. What problems does IaC solve compared to manually creating resources in the AWS console?
   - Instead of creating through GUI, terraform automates creation, deletion and updates
   - Ensures enviroments stays consistent by declaring desired state and reconciling differences.
   - Makes it easy to scale.
   - Manual means prone to error, by code error chances are very low.
   - Provides version control as it is stored in code.

3. How is Terraform different from AWS CloudFormation, Ansible, and Pulumi?
   - `Terraform` supports multicloud, is declarative, and focuses on Infrastructure 
     provisioning & lifecycle management.
   - `AWS cloudFromation` supports onyl AWS.
   - `Ansibe` focuses more on configuration management and app deployment.
   - `Pulumi` supports multicloud but it is imperative(like scripts).

4. What does it mean that Terraform is "declarative" and "cloud-agnostic"?
   - You don't need to write script step by step specifying what to do, you only need
     to write desired state that is `declarative.
   - Terraform can manage infrastructure across multiple cloud providers (AWS, Azure, 
     GCP, etc.) using the same tool and language (HCL). This is `cloud-agnostic`.

---

## Task 2: Install Terraform and Configure AWS
1. Install Terraform:
```bash
# macOS
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# Linux (amd64)
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Windows
choco install terraform
```

2. Verify:
```bash
terraform -version
```

   ![snapshot](images/2-a.png)

3. Install and configure the AWS CLI:
```bash
aws configure
# Enter your Access Key ID, Secret Access Key, default region (e.g., ap-south-1), output format (json)
```

4. Verify AWS access:
```bash
aws sts get-caller-identity
```

You should see your AWS account ID and ARN.

---

## Task 3: Your First Terraform Config -- Create an S3 Bucket
Create a project directory and write your first Terraform config:

```bash
mkdir terraform-basics && cd terraform-basics
```

Create a file called `main.tf` with:
1. A `terraform` block with `required_providers` specifying the `aws` provider
2. A `provider "aws"` block with your region
3. A `resource "aws_s3_bucket"` that creates a bucket with a globally unique name

Run the Terraform lifecycle:
```bash
terraform init      # Download the AWS provider
terraform plan      # Preview what will be created
terraform apply     # Create the bucket (type 'yes' to confirm)
```

Go to the AWS S3 console and verify your bucket exists.

   ![snapshot](images/3-a.png)

**Document:** What did `terraform init` download? What does the `.terraform/` directory contain?
   - `terraform init` downloads providers details.
   - `./terraform/`  has a lock file .terraform.lock.hcl to record the provider
     selections it made above.

---

## Task 4: Add an EC2 Instance
In the same `main.tf`, add:
1. A `resource "aws_instance"` using AMI `ami-0f5ee92e2d63afc18` (Amazon Linux 2 in ap-south-1 -- use the correct AMI for your region)
2. Set instance type to `t2.micro`
3. Add a tag: `Name = "TerraWeek-Day1"`

Run:
```bash
terraform plan      # You should see 1 resource to add (bucket already exists)
terraform apply
```

Go to the AWS EC2 console and verify your instance is running with the correct name tag.

   ![snapshot](images/4.png)

**Document:** How does Terraform know the S3 bucket already exists and only the EC2 instance needs to be created?
   - because terrafomr maintains state file.

---

## Task 5: Understand the State File
Terraform tracks everything it creates in a state file. Time to inspect it.

1. Open `terraform.tfstate` in your editor -- read the JSON structure
2. Run these commands and document what each returns:
```bash
terraform show                          # Human-readable view of current state
   - all resources created with detail
terraform state list                    # List all resources Terraform manages
 
   ![snapshot](images/5-a.png)

terraform state show aws_s3_bucket.<name>   # Detailed view of a specific resource
   - detail view of my_bucket
terraform state show aws_instance.<name>
   - detail vier of my-instance
```

3. Answer these questions in your notes:
   - What information does the state file store about each resource?
      - resource type, its name
      - dependencies (relationships between resources)
      - provider details
      - resource id
      - attributes ( IP addresses, DNS names, ARNs, bucket URLs etc)
   - Why should you never manually edit the state file?
      - Manually changing state file can cause drift. It can break terraform's ability to
        track resources.
   - Why should the state file not be committed to Git?
      - It contains secrets, ID's, credentials. Commiting to git can make it public.
      - Multiple people applying changing at same time can cause conflict and drift.

---

## Task 6: Modify, Plan, and Destroy
1. Change the EC2 instance tag from `"TerraWeek-Day1"` to `"TerraWeek-Modified"` in your `main.tf`
2. Run `terraform plan` and read the output carefully:
   - What do the `~`, `+`, and `-` symbols mean?
      - `Plan: 0 to add, 1 to change, 0 to destroy.`
      - It means no new resource to add, one to update and nothing to destroy.
   - Is this an in-place update or a destroy-and-recreate?
      - It is an in-place update.
3. Apply the change
4. Verify the tag changed in the AWS console

   ![snapshot](images/6.png)

5. Finally, destroy everything:
```bash
terraform destroy
```
6. Verify in the AWS console -- both the S3 bucket and EC2 instance should be gone

---

- What each Terraform command does (init, plan, apply, destroy, show, state list)
   - `init` : Initializes working directory by download providers details, modules.
   - `plan` : Shows all the resources it will add, change, destroy.
   - `apply` : Actually creates, changes, destroys resources.
   - `show` : Shows already created resources in detail.
   - `state list` : List all resources name.

---
