# This page is a quick reference for Terrafrom notes. I created this notebook to learn Terraform and prepare for the HashiCorp Certified: Terraform Associate exam. I hope you find it useful too.

## Terraform Commands

**terraform taint** - Manually marks a resource for recreation. This command will mark a resource for recreation during the next apply. This is deprecated in Terraform 0.12 and later. Use the `terraform apply` command with the `-replace` flag instead.

Example of tainting a resource:
```bash
terraform taint aws_instance.example
```

**terraform untaint** - Removes the tainted state from a resource. This command will remove the tainted state from a resource. This is deprecated in Terraform 0.12 and later. Use the `terraform apply` command without the `-replace` flag instead.

Example of untainting a resource:
```bash
terraform untaint aws_instance.example
```

Example of usage:
```bash
aws-ec2 git:(master) ✗ terraform taint 'aws_instance.ubuntu_ec2[0]'
Resource instance aws_instance.ubuntu_ec2[0] has been marked as tainted.

➜  aws-ec2 git:(master) ✗ terraform untaint 'aws_instance.ubuntu_ec2[0]'
Resource instance aws_instance.ubuntu_ec2[0] has been successfully untainted.
```

Newer versions of Terraform use the `terraform apply` command with the `-replace` flag to recreate a resource. This is the recommended way to recreate a resource in Terraform 0.12 and later.

Example of recreating a resource:
```bash
terraform apply -replace aws_instance.example
```


**terraform console** - Interactive console for evaluating expressions. This command opens an interactive console for evaluating expressions. You can use this command to test interpolations and functions before using them in your configuration files.

Example of using the console:
```bash
terraform console
> 1 + 1
2
```

**terraform graph** - Creates a visual representation of the Terraform graph. This command generates a visual representation of the Terraform graph. You can use this command to visualize the dependencies between resources in your configuration files.

Example of generating a graph:
```bash
terraform graph | dot -Tpdf > graph.pdf
or
terraform graph | dot -Tpng > graph.png
or
terraform graph | dot -Tsvg > graph.svg
```

