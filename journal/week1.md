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

```tf
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

## Dealing With Configuration Drift

## What happens if we lose our state file?

If you lose your state file `terraform.tfstate`, you most likely have to tear down all your cloud infrastructure manually.  
You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

[Importing Infrastructure](https://developer.hashicorp.com/terraform/cli/import)  
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)  
Import can be done through `import.tf` file or using command.  
Use the import block to import existing infrastructure resources into Terraform, bringing them under Terraform's management. Unlike the terraform import command, configuration-driven import using import blocks is predictable, works with CICD pipelines, and lets you preview an import operation before modifying state.

```bash
tf import aws_s3_bucket.example 25df7jmmiicxccchl7l67dkhi90v3l9y
```

After importing and trying to `tf plan` again random provider offers a new name and to destroy old (imported) bucket and create new one.

```bash
tf import aws_s3_bucket.example 25df7jmmiicxccchl7l67dkhi90v3l9y
```

And still: `aws_s3_bucket.example must be replaced`.

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps.

If we run Terraform plan is with attempt to put our infrastructure back into the expected state fixing Configuration Drift.

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is recommend to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg.:

- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLMs (Large Language Models) such as ChatGPT may not be trained on the latest documentation or information about Terraform.  
It may likely produce older examples that could be deprecated. Often affecting providers.

## Working with files in Terraform

### Fileexists function

This is a built in terraform function to check the existence of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

[Fileesists](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

ETag (entity tag) - that's the way to show, that uploaded file (resource) has changed - every time the content changes - the ETag will also change.  
[Filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)  
Filemd5 creates hash on the content of the file.

### Path Variable

In terraform there is a special variable called `path` that allows to reference local paths:

- path.module = get the path for the current module
- path.root = get the path for the root module

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}
```

## Terraform Local Values (locals)

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)  
Inline - in file definition of used values. Can be useful when data needs to be transformed into another format.  
A local value assigns a name to an expression, so you can use the name multiple times within a module instead of repeating the expression..

```tf
locals{
  s3_origin_id = "MyS3Origin"
}
```

## Terraform Data Sources

Allows to use to source data from cloud resources.  
This is useful to reference cloud resources without importing them.  
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

## Content Deliver Network

### Origin Access Control

[AWS OAC](https://aws.amazon.com/blogs/networking-and-content-delivery/amazon-cloudfront-introduces-origin-access-control-oac/)

### Bucket Policy - working with JSON

[jsonencode function](https://developer.hashicorp.com/terraform/language/functions/jsonencode) - encodes a given value to a string using JSON syntax. Here is used to create the JSON policy inline it the HCL.  
**Hashicorp Configuration Language** - HCL is a toolkit for creating structured configuration languages that are both human- and machine-friendly, for use with command-line tools. Although intended to be generally useful, it is primarily targeted towards devops tools, servers, etc.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

## Changing the Lifecycle of Resources

[The lifecycle Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

[The terraform_data Managed Resource Type](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

```tf
variable "revision" {
  default = 1
}

resource "terraform_data" "replacement" {
  input = var.revision
}

# This resource has no convenient attribute which forces replacement,
# but can now be replaced by any change to the revision variable value.
resource "example_database" "test" {
  lifecycle {
    replace_triggered_by = [terraform_data.replacement]
  }
}
```

## Provisioners

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax) allow to execute commands on compute instances eg. AWS CLI command.  
Not recommended for use by Hashicorp because Configuration Management tools such as Ansible are a better fit but the functionality exists.

### Local-exec

[local-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec) will execute a command on machine running the terraform commands eg. plan, apply.

```tf
resource "aws_instance" "web" {
  # ...
  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

### Remote-exec

[remote-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec) will execute a command on a remote machine - the one which you target. Will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...
  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```
