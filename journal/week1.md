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

To provide variable value inline use (-var flag) to set or overwrite a var in `.tfvars` file:  
`tf plan -var user_uuid="asdasas-asdd-dasda-sdasd-asdsad"`  
For normal use - put it in `terraform.tfvars` and the variables should be set in a TF cloud.  

### -var-file flag

To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either `.tfvars` or `.tfvars.json`) and then specify that file on the command line with `-var-file`:

```json
terraform apply -var-file="testing.tfvars"
```

### terraform.tfvars

The default file to load in terraform variables in blunk.

### auto.tfvars

Terraform also **automatically** loads a number of variable definitions files if they are present:

- Files named exactly `terraform.tfvars` or `terraform.tfvars.json`.
- Any files with names ending in `.auto.tfvar`s or `.auto.tfvars.json`.

### Order of TF Variables - Variables precedence

[Variable Definition Precedence](https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence)  
The mechanisms for setting variables can be used together in any combination. If the same variable is assigned multiple values, Terraform uses the last value it finds, overriding any previous values. Note that the same variable cannot be assigned multiple values within a single source.

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

- Environment variables
- The `terraform.tfvars` file, if present.
- The `terraform.tfvars.json` file, if present.
- Any `*.auto.tfvars` or `*.auto.tfvars.json` files, processed in lexical order of their filenames.
- Any `-var` and `-var-file` options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)
