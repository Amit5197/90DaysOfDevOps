# Day 64 -- Terraform State Management and Remote Backends

## Task
The state file is the single most important thing in Terraform. It is the source of truth -- the map between your `.tf` files and what actually exists in the cloud. Lose it and Terraform forgets everything. Corrupt it and your next apply could destroy production.

Today you learn to manage state like a professional -- remote backends, locking, importing existing resources, and handling drift.

---

## Challenge Tasks

### Task 1: Inspect Your Current State
Use your Day 63 config (or create a small config with a VPC and EC2 instance). Apply it and then explore the state:

```bash
terraform show                                    # Full state in human-readable format
terraform state list                              # All resources tracked by Terraform
terraform state show aws_instance.<name>          # Every attribute of the instance
terraform state show aws_vpc.<name>               # Every attribute of the VPC
```
Answer:
1. How many resources does Terraform track?
    - Terraform track 7 resources (Data sources are read-only and not counted)

2. What attributes does the state store for an EC2 instance? (hint: way more than what you defined)
    - `ami`,`instance_type`,`tags`,`key_name`

    - `private_ip`, `public_ip`, `private_dns`, `public_dns`, `subnet_id`, `vpc_security_group_ids`, `primary_network_interface_id`

    - `root_block_device` ,`volume_id`, `volume_size`, `volume_type`, `delete_on_termination`

3. Open `terraform.tfstate` in an editor -- find the `serial` number. What does it represent?
    - The serial number in `terraform.tfstate` represents how many times the state has been updated.
    - It increments with every change

---

### Task 2: Set Up S3 Remote Backend
Storing state locally is dangerous -- one deleted file and you lose everything. Time to move it to S3.

1. First, create the backend infrastructure (do this manually or in a separate Terraform config):
```bash
# Create S3 bucket for state storage
aws s3api create-bucket \
  --bucket terraweek-state-<yourname> \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1

# Enable versioning (so you can recover previous state)
aws s3api put-bucket-versioning \
  --bucket terraweek-state-<yourname> \
  --versioning-configuration Status=Enabled

# Create DynamoDB table for state locking
aws dynamodb create-table \
  --table-name terraweek-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region ap-south-1
```

<img width="1896" height="957" alt="image" src="https://github.com/user-attachments/assets/b58f9a2e-f8ef-4266-af16-d1e0bbb6a1b4" />

<img width="1572" height="807" alt="image" src="https://github.com/user-attachments/assets/95aad803-eba1-4d2d-ad68-eccf332f41d4" />

2. Add the backend block to your Terraform config:
```hcl
terraform {
  backend "s3" {
    bucket         = "terraweek-state-<yourname>"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraweek-state-lock"
    encrypt        = true
  }
}
```

3. Run:
```bash
terraform init
```
Terraform will ask: "Do you want to copy existing state to the new backend?" -- say yes.

4. Verify:
   - Check the S3 bucket -- you should see `dev/terraform.tfstate`
   - Your local `terraform.tfstate` should now be empty or gone
   - Run `terraform plan` -- it should show no changes (state migrated correctly)


<img width="1052" height="487" alt="image" src="https://github.com/user-attachments/assets/2a1ada20-b037-4119-9306-1e5a1f1e9092" />

<img width="1812" height="562" alt="image" src="https://github.com/user-attachments/assets/83f3d166-5995-4731-bb40-c7c870eb5809" />

<img width="1224" height="435" alt="image" src="https://github.com/user-attachments/assets/4cba0246-9df2-4a02-aba7-29ce85b5f90f" />

---

### Task 3: Test State Locking
State locking prevents two people from running `terraform apply` at the same time and corrupting the state.

1. Open **two terminals** in the same project directory
2. In Terminal 1, run:
```bash
terraform apply
```
3. While Terminal 1 is waiting for confirmation, in Terminal 2 run:
```bash
terraform plan
```
4. Terminal 2 should show a **lock error** with a Lock ID

<img width="1825" height="507" alt="image" src="https://github.com/user-attachments/assets/f4d9f157-d4cc-4f20-97ea-9bd0381a68cc" />

**Document:** What is the error message? Why is locking critical for team environments?

- `Error:`Terraform can’t acquire the state lock because DynamoDB says the state is already locked (ConditionalCheckFailedException).

- `Why locking matters:` It prevents concurrent writes, which could corrupt the state file and cause unintended infrastructure changes—critical in team environments.

5. After the test, if you get stuck with a stale lock:
```bash
terraform force-unlock <LOCK_ID>
```

---

### Task 4: Import an Existing Resource
Not everything starts with Terraform. Sometimes resources already exist in AWS and you need to bring them under Terraform management.

1. Manually create an S3 bucket in the AWS console -- name it `terraweek-import-test-<yourname>`

<img width="1267" height="517" alt="image" src="https://github.com/user-attachments/assets/580685a6-a968-47e8-94a6-3d3fe8d41d37" />

2. Write a `resource "aws_s3_bucket"` block in your config for this bucket (just the bucket name, nothing else)
3. Import it:
```bash
terraform import aws_s3_bucket.imported terraweek-import-test-<yourname>
```
4. Run `terraform plan`:
   - If you see "No changes" -- the import was perfect
   - If you see changes -- your config does not match reality. Update your config to match, then plan again until you get "No changes"

5. Run `terraform state list` -- the imported bucket should now appear alongside your other resources

<img width="1427" height="922" alt="image" src="https://github.com/user-attachments/assets/a0c2f16b-5857-4583-9dae-59fec10cd239" />

**Document:** What is the difference between `terraform import` and creating a resource from scratch?

`terraform import`
- Bring an existing resource (already in AWS, etc.) under Terraform management
- Updates the Terraform state file to track the resource
- `use case` Migrating manual or existing resources into Terraform
- `Example:`
    ```bash
    # Import an existing S3 bucket
    terraform import aws_s3_bucket.imported terraweek-import-test-sanketdangat
    ```
    
`Creating a Resource from Scratch`
- Terraform creates a new resource in the cloud
- Both state and actual resource are created by Terraform
- `use case` Standard workflow when starting from scratch
- `Example:`
    ```bash
    # Create a new S3 bucket from scratch
    resource "aws_s3_bucket" "new" {
    bucket = "terraweek-new-bucket"
    }

    ```

---

### Task 5: State Surgery -- mv and rm
Sometimes you need to rename a resource or remove it from state without destroying it in AWS.

1. **Rename a resource in state:**
```bash
terraform state list                              # Note the current resource names
terraform state mv aws_s3_bucket.imported aws_s3_bucket.logs_bucket
```
Update your `.tf` file to match the new name. Run `terraform plan` -- it should show no changes.

<img width="1567" height="347" alt="image" src="https://github.com/user-attachments/assets/c18ac34d-cbe0-40d2-81d7-e0341e8ff2f2" />
<img width="1051" height="975" alt="image" src="https://github.com/user-attachments/assets/2cd1b6ba-cf4c-4920-9322-d8d9c2507dee" />
<img width="1155" height="990" alt="image" src="https://github.com/user-attachments/assets/1e6da62c-75b4-4a41-bab8-c45e11c83e7f" />

2. **Remove a resource from state (without destroying it):**
```bash
terraform state rm aws_s3_bucket.logs_bucket
```
Run `terraform plan` -- Terraform no longer knows about the bucket, but it still exists in AWS.

<img width="1267" height="592" alt="image" src="https://github.com/user-attachments/assets/deddbdf8-6c80-4fc7-921e-fa1bf87d4a4a" />

3. **Re-import it** to bring it back:
```bash
terraform import aws_s3_bucket.logs_bucket terraweek-import-test-<yourname>
```

**Document:** When would you use `state mv` in a real project? When would you use `state rm`?

- **When to Use state `mv`**
  - Renaming resources: Change a resource block name in your code (e.g., from aws_instance.old to aws_instance.new) without forcing Terraform to delete and recreate the server.
  - Moving into modules: Reorganize your flat files by shifting a resource inside a new child module path in your state.
  - Changing loops: Switch a resource from using count or for_each without losing track of existing live objects.
  - Splitting state files: Move specific resources safely between different state files or environments. 

```terraform state mv aws_s3_bucket.my_bucket aws_s3_bucket.logs_bucket```

- **When to Use state `rm`**
  - Orphaning safely: Stop tracking a shared or legacy resource (like a production database or shared network) so future apply commands ignore it instead of deleting it. 
  - Migrating across projects: Pull a resource out of one distinct Terraform project's state before importing it into a completely separate project. 
  - Cleaning up deleted items: Remove stale entries from your state file if the real infrastructure was already manually destroyed outside of Terraform.

```terraform state rm aws_db_instance.legacy_db```

---

### Task 6: Simulate and Fix State Drift
State drift happens when someone changes infrastructure outside of Terraform -- through the AWS console, CLI, or another tool.

1. Apply your full config so everything is in sync
2. Go to the **AWS console** and manually:
   - Change the Name tag of your EC2 instance to `"ManuallyChanged"`
   - Change the instance type if it's stopped (or add a new tag)

<img width="1207" height="492" alt="image" src="https://github.com/user-attachments/assets/ac011797-ace0-4537-bf6f-97773f5482c4" />


3. Run:
```bash
terraform plan
```
You should see a **diff** -- Terraform detects that reality no longer matches the desired state.

<img width="1332" height="412" alt="image" src="https://github.com/user-attachments/assets/7e468d6e-0ce2-4465-a6ac-aea9f15594ec" />

4. You have two choices:
   - **Option A:** Run `terraform apply` to force reality back to match your config (reconcile)
   - **Option B:** Update your `.tf` files to match the manual change (accept the drift)

5. Choose Option A -- apply and verify the tags are restored.

- Yes
  
<img width="1432" height="485" alt="image" src="https://github.com/user-attachments/assets/fcceec0f-f381-48b7-89ca-7ee8fd9bafdf" />

6. Run `terraform plan` again -- it should show "No changes." Drift resolved.

<img width="1315" height="816" alt="image" src="https://github.com/user-attachments/assets/83f86290-312f-4f65-91a3-d42a01a5aa6b" />

**Document:** How do teams prevent state drift in production? (hint: restrict console access, use CI/CD for all changes)

- Teams prevent state drift in production by restricting console access and ensuring all changes go through CI/CD pipelines with version-controlled configurations.

---

## Documentation
Create `day-64-state-management.md` with:
- Diagram: local state vs remote state setup

<img width="1192" height="782" alt="image" src="https://github.com/user-attachments/assets/ff7ee3ce-6cf0-4c98-ad50-c3a63a0656b8" />

- Steps you followed for `terraform import` and the result

1. `Write the Terraform resource block:`
  - Make sure the name matches the existing bucket exactly:
    ```bash
    resource "aws_s3_bucket" "imported" {
    bucket = "terraweek-import-test-sanketdangat"
    }
    ```
  - `Note:` Don’t include any other arguments yet (ACLs, versioning, etc.). Just the bucket name.

2. `Import the existing bucket`
  - `Run the command:`
    ```bash
    terraform import aws_s3_bucket.imported terraweek-import-test-sanketdangat
    ```
  - Here:
    `aws_s3_bucket.imported` : resource type + Terraform name
    `terraweek-import-test-sanketdangat` : existing AWS bucket name

3. `Check Terraform state`
  - `terraform state list`
  - You should see `aws_s3_bucket.imported` listed.


- Explanation of state drift with your real example

 - State drift happens when someone changes infrastructure outside of Terraform -- through the AWS console, CLI, or another tool.

- Go to the AWS console and manually:
- add a new tag Owner:amit

- When to use: `state mv`, `state rm`, `import`, `force-unlock`, `refresh`

  -  `state mv`	Rename/move a resource in state without recreating it
  -  `state rm`	Stop Terraform from managing a resource
  -  `import`	Bring an existing resource under Terraform management
  -  `force-unlock`	Unlock a stuck state file after a failed operation
  -  `refresh`	ync state with real-world resources (detect drift)

---

Happy Learning!
**TrainWithShubham**
