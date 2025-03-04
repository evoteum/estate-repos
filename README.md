# estate-repos

**estate-repos** automates the creation and management of repositories within the [evoteum](https://github.com/evoteum) organization.

## Why?
Creating and managing repositories manually is time-consuming and error-prone. Using estate-repos, we ensure consistency
and efficiency.

- **Automated Repository Creation**: Simply add the repository name, description, and any required attributes to `repos.yaml`.
- **Consistent Configuration**: Ensures all repositories follow organizational standards.
- **Scalable and Flexible**: Easily add and modify repositories.

...Because everyone ❤️ YAML.


## Usage
### Creating repos

1. To avoid the [XY problem](https://xyproblem.info/), and to check that others like the name, please
[propose new repositories](https://github.com/orgs/evoteum/discussions/new?category=polls).
1. Once agreed, add new repositories to repos.yaml

> [!NOTE]  
> We do not rename repositories because it breaks links and references. Discuss the name before creating the repository. 

#### Example
```yaml
my-new-repo:
  description: A new project for evoteum.
  topics:
    - devops
    - automation
 ```

#### Variables

Each repository entry in repos.yaml can include the following parameters:

| Parameter          | Required | Default      | Permitted values    | Description                                                                                      |
|--------------------|----------|--------------|---------------------|--------------------------------------------------------------------------------------------------|
| key                | ❗ Yes    |              | Any string          | The name of the repository.                                                                      |
| `description`      | ❗ Yes    |              | Any string          | A brief description of the repository.                                                           |
| `homepage_url`     | 👍 No    |              | Any string          | The URL of the project's homepage.                                                               |
| `artifact_type`    | 👍 No    |              | `container`         | The deployment artifact that the project should produce. Creates an artifact repository in Quay. |
| `build_flags`      | 👍 No    |              | Any string          | Flags to add to the build command.                                                               |
| `language`         | 👍 No    |              | Any string          | The language that the project is written in.                                                     |
| `language_version` | 👍 No    |              | Any string          | The version of the language that the project is written in.                                      |
| `source_path`      | 👍 No    |              | Any string          | Path to the source code directory (not the tofu code)                                            |
| `topics`           | 👍 No    |              | List of any strings | A list of topics associated with the repository.                                                 |
| `archived`         | 👍 No    | false        | `true`, `false`     | Whether the repository is archived.                                                              |
| `environments`     | 👍 No    | [discovered] | List of any strings | List of environment names. Discovered if omitted.                                                |
| `fail_fast`        | 👍 No    | true         | `true`, `false`     | Whether all deployments should fail if one environment fails.                                    |
| `has_discussions`  | 👍 No    | false        | `true`, `false`     | Whether GitHub Discussions are enabled for the repository.                                       |
| `has_issues`       | 👍 No    | true         | `true`, `false`     | Whether GitHub Issues are enabled for the repository.                                            |
| `has_projects`     | 👍 No    | false        | `true`, `false`     | Whether GitHub Projects are enabled.                                                             |
| `has_wiki`         | 👍 No    | false        | `true`, `false`     | Whether the GitHub Wiki is enabled.                                                              |
| `visibility`       | 👍 No    | `public`     | `public`, `private` | Determines if the repository is public or private.                                               |

> [!IMPORTANT]  
> Where default values are provided, they should be used **unless absolutely necessary** to override them.  
>  
> Default values are carefully chosen to ensure consistency, maintainability, and best practices across the estate.
 

### Archiving repos

> [!CAUTION]
> Archiving is permanent! Please [propose archiving](https://github.com/orgs/evoteum/discussions/new?category=polls) before proceeding.

If the community agree that the repository should be archived,
1. prepend the repo readme with a note alert that includes a link to the discussion for future context.

    ```markdown
    > [!NOTE]
    > Following [community discussion](link-to-discussion), this project has been concluded, so this repository is no longer maintained. Thank you to all contributors and users for your support.
    ```

2. add `archived: true` to the repo in `repos.yaml`.
3. Coffee.


> [!IMPORTANT]  
> We do not delete repositories because they may contain valuable information.
> 
> Removing repos from repos.yaml will cause a [`prevent_destroy`](https://opentofu.org/docs/language/meta-arguments/lifecycle/#:~:text=contains%20more%20details.-,prevent_destroy,-(bool)%20-%20This%20meta) error.


## Contributing

Contributions are welcome! 


## License

This project is licensed under the AGPL-3.0 License. See the [LICENSE](LICENSE) file for details.
