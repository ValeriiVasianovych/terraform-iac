## How to recreate specific resource using taint or replace on Terraform 
To recreate a specific resource in Terraform, you can use one of these methods:  

1. **Using `taint` `untaint` (Deprecated in Terraform 1.2+)**  
   ```sh
   terraform taint resource_type.resource_name
   terraform apply
   ```
   This marks the resource for recreation on the next `apply`.  

2. **Using `-replace` (Recommended)**  
   ```sh
   terraform apply -replace="resource_type.resource_name"
   ```
   This forces Terraform to destroy and recreate the specified resource during the apply step.  