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

