To use tfvars files in Terraform, you can create a file with the `.tfvars` extension and pass it to the `terraform apply` command using the `-var-file` flag. This is useful when you have multiple environments and want to keep your variables separate from your main configuration file.

Here's an example of how to use tfvars files in Terraform:
```bash
terraform apply -var-file=dev.tfvars
```

To add variable values to your tfvars file, you can use the following syntax:
```hcl
variable_name = "value"
```

You can also add values to variables when you run the `terraform apply` command by using the `-var` flag:
```bash
terraform apply -var="variable_name=value"
```

