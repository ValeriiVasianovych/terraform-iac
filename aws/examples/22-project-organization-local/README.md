## Example of organizing Terraform project with local modules and environments
```
├── README.md
├── envs
│   ├── dev
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── prod
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── global
│   ├── s3-bucket.tf
│   └── variables.tf
└── modules
    └── vpc
        ├── datasource.tf
        ├── outputs.tf
        ├── subnets.tf
        ├── variables.tf
        └── vpc.tf
```