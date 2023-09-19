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

----
> [**Commit Message Guidelines**](https://gist.github.com/robertpainsi/b632364184e70900af4ab688decf6f53)
>
> - Do not end the subject line with a period
> - Capitalize the subject line and each paragraph
> - Use the imperative mood in the subject line

----

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

----

Commit changes, create PR and marge it, fetch, checkout main, pull, and add tag: 0.2.0  
Stop Workspace.
