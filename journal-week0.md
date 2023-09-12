# Terraform Beginner Bootcamp 2023

## Pre-week

### Create repo from repository

* Go to [github template repo](https://github.com/ExamProCo/terraform-beginner-bootcamp-2023)
* Click *Use this template* and then *Create a new repository*.  
* Make sure the repository name is exactly: **terraform-beginner-bootcamp-2023** and make sure it's the only repository with that name (it's available).
* Give it a description if you want.
* Make sure it is **Public**

    > Repository name and public access is needed for automatic validator!

* Click *Create repository*

```bash
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/key_for_github
    git clone git@github.com:..../terraform-beginner-bootcamp-2023.git
```

### Jumppad - demo environments simplified

[Jumppad](https://jumppad.dev) - Jumppad enables the creation and configuration of lightweight, reproducible, and portable environments as code.  

To use Jumppad you need a recent version of Docker and the Git CLI installed on your system.

* Docker
* Git

[Installation docs](https://jumppad.dev/docs/introduction/installation) - 
Quick install (Linux, Mac and Windows WSL2).  
The quick install script allows you to easily install the latest version of Jumppad. Run the following command in your terminal, the install script will prompt you for administrator access if required.

> curl https://jumppad.dev/install | bash

Or using a package manager in Debian

```bash
    echo "deb [trusted=yes] https://apt.fury.io/jumppad/ /" | \
    sudo tee -a /etc/apt/sources.list.d/fury.list

    sudo apt-get update

    sudo apt-get install jumppad
```

[Terraform Workshop](https://github.com/jumppad-labs/terraform-workshop) - clone the repo and ```jumppad up```.

### Git & Gitpod

[Gitpod](https://gitpod.io)

* Create gitpod account.
* Install gitpod plugin in your browser.
* You'll see gitpod button on repository page on your github account.

Click to Gitpod button, open new Workspace (repo name, editor - VS Code, and Standard machine).

Workflow:

* make a change
* commit changes to github (with a message)
* sync our changes (push)


