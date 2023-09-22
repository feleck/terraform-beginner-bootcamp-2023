# Terraform Beginner Bootcamp 2023

## Week 0 (Project Prep)

### Branching Tagging PR (:mage:)

> Repository name: [terraform-beginner-bootcamp-2023](https://github.com/feleck/terraform-beginner-bootcamp-2023)

#### [Semantic Versioning](https://semver.org/spec/v2.0.0.html)

Generally - branch maned after the ticket (feature) - after creating an issue we got the number (#1)

```bash
$ git checkout -b 1-semantic-versioning
Switched to a new branch '1-semantic-versioning'
$ git push --set-upstream origin 1-semantic-versioning
```

#### This project is going to utilize semantic versioning for its tagging

The general format:
  
  **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

---
> [**Commit Message Guidelines**](https://gist.github.com/robertpainsi/b632364184e70900af4ab688decf6f53)
>
> - Do not end the subject line with a period
> - Capitalize the subject line and each paragraph
> - Use the imperative mood in the subject line
>
>---

```bash
git add .
git commit -m 'Add documentation for the semantic versioning'
git commit --amend -m “new commit message” #if need to update the message
git tag 0.1.0
git push --tags
```

| [oh my bash](https://github.com/ohmybash/oh-my-bash) - consider checking out

When branch is pushed and tagged - go to *Pull requests* on github and create *New pull request*. Feature branch to the main - that's the direction. Add description. When `squash and merge` - all commits are squashed in PR.

If branch was named like issue (1-semantic-versioning) it should connect PR with the issue.

> ***Stop Gitpod Workspace!*** to spare some time  
> Tag **after** merging the Pull Request  
> Do not delete branches (for inspection)

### Terraform CLI Refactor (:mage:)

Automatic installation of Terraform CLI when starting in Gitpod requires user activity - need to be full automated - `.gitpod.yml` need to be corrected.  
So create new issue: [Refactor Terraform CLI #4](https://github.com/feleck/terraform-beginner-bootcamp-2023/issues/4), label it as Bug and create new branch: `git checkout 4-refactor-terraform-cli`.  
Switch to new branch and open Gitpod env.  

#### Considerations for Linux Distribution

Checking Linux distribution - `cat /etc/os-release`.  

Local env: Debian, Gipod: Ubuntu.  

For Gitpod:

```shell
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

and for local:

```shell
PRETTY_NAME="Debian GNU/Linux trixie/sid"
NAME="Debian GNU/Linux"
VERSION_CODENAME=trixie
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
```

##### [Linux Permissions](https://en.wikipedia.org/wiki/Chmod)

`chmod`

##### [Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) -  

`#!/bin/env bash`

##### Execution

`./` shorthand notation  
`./bin/install_terraform_cli`  
In .gitpod.yml need to point the script toa program to interpret it: `source ./bin/install_terraform_cli`  

#### Considerations with the Terraform CLI installation changes

The Terraform CLI installation instructions have changed due to gpg keyring changes. So the original [.gitpod.yml](.gitpod.yml) bash configuration had to be updated with a reference to the latest instructions via Terraform Documentation and change the scripting for install.

[Terraform installation documentation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)  

#### Refactoring into Bash Scripts

While fixing the TF CLI gpg deprecation issue we noticed that there were more code in installation steps. So we decided to create a bash script to install the TF CLI.  

- this will keep the Gitpod Task File tidy.
- this will allow us an easier to debug and execute manually TF CLI install
- this will allow better portability for other projects that need to install TF CLI

The script is located [./bin/install_terraform_cli](./bin/install_terraform_cli)
Create script from Terraform instructions, add permissions to run (`chmod u+x` or `chmod 744`) and update `.gitpod.yml` to run it when starting the environment.  

#### [Gitpod tasks](https://gitpod.io/docs/configure/workspaces/tasks)

- before
- init (only for new workspace - not for existing one (on restart))
- command

---

Commit changes, create PR and marge it, fetch, checkout main, pull, and add tag: 0.2.0  
Stop Workspace.

### Working with Env Vars

[Shell vs Env Vars description](https://www.baeldung.com/linux/bash-variables-export)

- List all variables using `env` command. Filter specific env vars using grep: `env | grep ROOT`.
- In the terminal, set using var name, equal sign and value in single quotes: `VARIABLE='some value'` - this is a **shell variable**.
- Can be used temporarily running command:

  ```sh
    HELLO='world' ./bin/print_message`
  ```

- Export usage: `export VARIABLE='some value'` - this is an **env variable**
- Un-setting: `unset VARIABLE`
- Using (in a script): with `$` sign at the beginning: `$VARIABLE`
- Within a bash script `export` can be omitted:

  ```sh
    #!/bin/env bash
    HELLO='world'

    echo $HELLO
  ```

- Printing: using echo `echo $HELLO`
- Scoping - new bash terminal in VSCode it won't be aware of other terminal env vars. If you want Env Vars to persist access all future bash terminals you need to set env vars in your bash profile `~/.bash_profile` file.

#### Env Vars in Gitpod

Store Env Variables in Gitpod User Variables [https://gitpod.io/user/variables](https://gitpod.io/user/variables) using:

```sh
gp env HELLO='world'
```

All future workspaces will set the env vars (according to set scope).
Env vars can be stored in `.gitpod.yml` but **DO NOT** store there ANY sensitive data (keys, passwords etc.)

### AWS CLI installation

AWS CLI is installed for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)  
[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)  

To check if AWS credentials are configured correctly use:

```sh
aws sts get-caller-identity
```

[Environment variables to configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

When successful response should look like this:

```json
{
    "UserId": "AKIAIOSFODNN7EXAMPLE",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform_bootcamp_username"
}
```

Need to generate AWS CLI credentials from AWS IAM User in order to the user AWS CLI.

### [Terraform providers](https://registry.terraform.io/browse/providers)

Terraform sources their providers and modules from the Terraform registry which is located at **[registry.terraform.io](https://registry.terraform.io)**

---
> **Provider** is a **mapping (interface) API to resources**, allows to create resources in code. Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.  
> You must configure the provider with the proper credentials before you can use it.
>
> **Modules** are self-contained packages of Terraform configurations (templates) that are managed as a group. This is a way to make a large amount of tf code portable, modular and shareable.
>
> ---

#### AWS Provider documentation: [https://registry.terraform.io/providers/hashicorp/aws/latest/docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

#### Random provider [https://registry.terraform.io/providers/hashicorp/random/latest](https://registry.terraform.io/providers/hashicorp/random/latest)

Root (top) level module is in [main.tf](./main.tf) - we are making a module.

First we have provider, then we have to provide resource.

random_string resource [https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)

> #### Terraform Main Commands
>
> command: `terraform`
>
>- init - Prepare your working directory for other commands
>- validate - Check whether the configuration is valid
>- plan - Show changes required by the current configuration
>- apply - Create or update infrastructure
>- destroy - Destroy previously-created infrastructure

In every TF project at the very beginning:

```sh
terraform init
```

Creates lock file (locked versioning for providers and modules) [.terraform.lock.hcl](./.terraform.lock.hcl). It **should be commited to repository**(VCS).

> VCS - Version Control System

It also creates `.terraform` folder, which contains binary for provider (written in go and distributed as binary).  It **should *not* be commited to repository** (VCS).
Make sure `.terraform` folder is ignored in [.gitignore](./.gitignore) file - not commited to repository (and ignored many more files).  

We can make a ***plan***.  

```sh
terraform plan
```

It is creating a changeset - this is what is planned to change.
If run with `-out` you can save it to a file for later execution (often can be omitted).

```sh
terraform apply #--auto-approve
```

Runs the plan and executes it. Always asks if you are sure you want to deploy, can be auto approved with a flag: `--auto-approve`.

After a change in main.tf - `terraform plan` again, verify what is going to be changed.
Output can be checked wit `terraform output` or if wanted exact output(only value): `terraform output random_bucket_name`.

`terraform apply` creates a [terraform.tfstate](./terraform.tfstate) file which contains information about a current state of infrastructure - no case to edit this file - and [terraform.tfstate.backup](./terraform.tfstate.backup) - backup file. `"serial": 2,` indicates the version. Can contain sensitive data! Lo  
It **should *not* be commited to repository** (VCS).

To destroy resources use:

```sh
terraform destroy
```

(with flag `--auto-approve` if you don't want to approve by hand)

### S3 Bucket

First need to add AWS provider (blocks terraform and required_providers can be used only once in a file).
Then - resource: aws_s3_bucket.

#### AWS Provider Authentication and Configuration

- Not recommended: directly inside a block. (would be comitted to VCS)
- Using env variables

### Issues with Terraform Cloud and Gitpod Workspace

When attempting to `terraform login` it will launch bash a wiswig view to generate a token. However it doesn't work as expected in Gitpod Workspace terminal. After `Shift+Q` - quitting wiswig browser it showed URL to CTRL-CLICK to follow, that allowed to generate token, which later could be copied and (Ctrl+Shift+V) pasted into terminal and saved in `/home/gitpod/.terraform.d/credentials.tfrc.json` json file which is formatted like this:

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "thisIsaFakeToken"
    }
  }
}
```

Token is generated on [https://app.terraform.io/app/settings/tokens?source=terraform-login](https://app.terraform.io/app/settings/tokens?source=terraform-login) and can be generated manually and pasted to the file above.

To automate the process of generating this file we've created new env variable (and gp env) TERRAFORM_CLOUD_TOKEN and script to set tfrc file:
[bin/generate_tfrc_credentials)](bin/generate_tfrc_credentials)
