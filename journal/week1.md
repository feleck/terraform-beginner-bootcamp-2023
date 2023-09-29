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

## Move from Cloud to local state

Migrate from cloud back to local - to do that need to set env variables in terraform cloud (allow TF Cloud to access AWS).
Then delete `.terraform.lock.hcl` file and `.terraform` folder just in case.

## Terraform Tagging

S3_bucket tags:

```json
tags = {
    Name    = "My bucket"
    Environment = "Dev"
}
```

## Terraform and Input Variables

[Input variables documentation](https://developer.hashicorp.com/terraform/language/values/variables)

### Terraform Cloud Variables


> **In TF we can set two kind of variables**:
>
> - **Environment** Variables - set in bash terminal eg. AWS credentials
> - **Terraform** Variables - set in tfvars file

TF Cloud vars can be set as sensitive - are not shown in an UI.

### Loading Terraform Input Variables

### -var flag

To provide variable value inline use (-var flag) to set or overwrite a var in tfvars file:  
`tf plan -var user_uuid="asdasas-asdd-dasda-sdasd-asdsad"`  
For normal use - put it in `terraform.tfvars` and the variables should be set in a TF cloud.  

### -var-file flag

[Homework]

### terraform.tfvars

The default file to load in terraform variables in blank.

### auto.tfvars

[Homework]

### Order of TF Variables

Variables precedence
