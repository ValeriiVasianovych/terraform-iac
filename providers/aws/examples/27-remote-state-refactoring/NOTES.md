## Safe Commands  
- **`terraform state show [address]`** – Displays detailed information about a resource in the Terraform state. Useful for inspecting the current configuration of a specific resource.  
- **`terraform state list`** – Lists all resources currently tracked in the Terraform state. Helps in identifying existing resources before making modifications.  
- **`terraform state pull`** – Fetches and outputs the entire Terraform state in JSON format. This can be used for backup or analysis without modifying the state.  

## Dangerous Commands  
- **`terraform state rm [address]`** – Removes a resource from the Terraform state but does not delete it from the infrastructure. Use with caution, as Terraform will no longer manage the resource.  
- **`terraform state mv [source] [destination]`** – Moves a resource within the Terraform state, allowing renaming or refactoring of resources. If misused, it can lead to configuration mismatches.  
- **`terraform state push`** – Manually uploads a modified state file to remote storage. Can overwrite the state and cause inconsistencies if not used carefully.  

## Scenario  
```bash
➜  all git:(master) ✗ tree
.
├── NOTES.md
├── all
│   ├── main.tf
│   ├── terraform-state-output.tfstate
│   └── variables.tf
├── production
│   ├── instance-prod.tf
│   ├── main.tf
│   ├── sg-prod.tf
│   └── variables.tf
└── staging
    ├── instance-staging.tf
    ├── main.tf
    ├── sg-staging.tf
    └── variables.tf

4 directories, 12 files
```

### Steps to Split Environments
1. Initially, all resources for DEV and STAGING exist in a single `.tfstate` file stored in S3. This is not best practice, as all environments share the same state.
2. To properly separate them:
    - Divide files into separate directories: `production` and `staging`.
    - Move states from the shared `all` `.tfstate` file into respective environment-specific state files using `terraform state list` to identify managed resources.

### Moving Resources to Their Specific States
```bash
➜  all git:(master) ✗ terraform state list
aws_instance.instance-1
aws_instance.instance-2
aws_security_group.sg-1
aws_security_group.sg-2
```

#### Moving Production Resources
Move `instance-prod-1` from the shared state file to a new `terraform.tfstate` file for production:
```bash
terraform state mv -state-out="terraform.tfstate" aws_instance.instance-1 aws_instance.instance-1
```
Move `security-group-prod`:
```bash
terraform state mv -state-out="terraform.tfstate" aws_security_group.sg-1 aws_security_group.sg-1
```
Now the `all` state file contains:
```bash
➜  all git:(master) ✗ terraform state list
aws_instance.instance-2
aws_security_group.sg-2
```

#### Transferring State to Production Directory
Move `terraform.tfstate` to `production/`, configure the new backend, and initialize:
```bash
mv terraform.tfstate ../production
cd ../production
terraform init
```
Terraform will prompt to copy the state to the new backend:
```bash
Do you want to copy existing state to the new backend? Enter "yes" to proceed.
```
Validate migration:
```bash
terraform plan
```

#### Moving Staging Resources
Repeat the process for staging:
```bash
terraform state mv -state-out="terraform.tfstate" aws_security_group.sg-2 aws_security_group.sg-2
terraform state mv -state-out="terraform.tfstate" aws_instance.instance-2 aws_instance.instance-2
```
Check the updated state:
```bash
terraform state list  # Should be empty
```
Move the state file to the staging directory and initialize:
```bash
mv terraform.tfstate ../staging
cd ../staging
terraform init
terraform plan
```

### Moving All Resources from Shared State to a New `.tfstate` File
```bash
for i in $(terraform state list); do terraform state mv -state-out="terraform.tfstate" $i $i; done
```

## Deleting Specific Resources from State
Remove a specific resource:
```bash
terraform state rm aws_instance.example-instance
```
Remove all resources using a loop:
```bash
for i in $(terraform state list); do terraform state rm $i; done
```

## Handling Missed Resources After Migration
If you forgot to move some resources:
1. Go to the `production` directory:
    ```bash
    cd production
    terraform state pull > terraform.tfstate
    ```
2. Identify the missing resource in `all`:
    ```bash
    terraform state list  # Look for the missing resource
    ```
3. Move the missing resource:
    ```bash
    terraform state mv -state-out="../production/terraform.tfstate" aws_security_group.sg-forgotten aws_security_group.sg-forgotten
    ```
4. Move the corresponding Terraform configuration to `production/`.
5. Push the updated state to the remote backend in `production/`:
    ```bash
    terraform state push terraform.tfstate
    ```
6. Validate changes:
    ```bash
    terraform plan
    terraform apply
    ```
7. Once confirmed, delete the local `terraform.tfstate` file since the state is now stored remotely.

---
