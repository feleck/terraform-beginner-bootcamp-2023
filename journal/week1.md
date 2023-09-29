# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Structure is as follows:

```ascii
PROJECT ROOT
│
├── main.tf - everything else
├── variables.tf - stores the structure of input variables
├── terraform.tfvars - the data of variables we want to load  into out terraform project
├── providers.tf - defined required providers and their configuration
├── outputs.tf - stores outputs
└── README.md - required for root modules

```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
