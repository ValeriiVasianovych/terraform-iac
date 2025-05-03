## How to import ec2
1. Create empty resource
2. `terraform import resource.name_id id_resource`
3. tf plan, errors shows you what you need to manage resource
4. add some parameters from errors
5. `terraform plan`, show config. `terraform apply` and it works