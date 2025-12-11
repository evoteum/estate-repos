# estate-repos

**estate-repos** automates the creation and management of repositories within the [evoteum](https://github.com/evoteum) organisation.

## Automation Features

Every automation below is managed through `repos.yml`, enabling seamless management of the entire repository estate with
a single commit.

1. **GitHub Repository Management**
   - Automated repository creation with standardized README
   - Repository settings and configurations
   - Automated repository updates

1. **GitHub Actions Workflow Management**
   - Automatic workflow deployment based on repository configuration
   - Centrally managed reusable workflows
   - Zero-touch workflow updates across all repositories
   - Schedule-based workflow triggers

1. **Variable Management**
   - Repository-specific variables
   - Environment-specific configurations
   - Build and deployment settings

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
  - name: testy-mctestface
    artifact_type: container
    description: Sandbox for testing
    language: python
    language_version: 3.13.0
    source_path: python
    needs_tofu: true
    needs_auto_docs: true
    fail_fast: false
 ```

#### Configuration Variables

> [!IMPORTANT]
> Where default values are provided, they should be used **unless absolutely necessary** to override them.
>
> Default values are carefully chosen to ensure consistency, maintainability, and best practices across the estate.

Each repository entry in `repos.yml` can include the following parameters:

| Parameter             | Required | Default      | Permitted values                                               | Description                                                                                           |
|-----------------------|----------|--------------|----------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| key                   | ❗ Yes    |              | Any string                                                     | The name of the repository.                                                                           |
| `description`         | ❗ Yes    |              | Any string                                                     | A brief description of the repository.                                                                |
| `homepage_url`        | 👍 No    |              | Any string                                                     | The web address of the application.                                                                   |
| `build_flags`         | 👍 No    |              | Any string                                                     | Flags to add to the build command.                                                                    |
| `language`            | 👍 No    |              | Any string                                                     | The language that the project is written in.                                                          |
| `language_version`    | 👍 No    |              | Any string                                                     | The version of the language that the project is written in.                                           |
| `source_path`         | 👍 No    |              | Any string                                                     | Path to the source code directory (not the tofu code)                                                 |
| `topics`              | 👍 No    |              | List of any strings                                            | A list of topics associated with the repository.                                                      |
| `trigger_files`       | 👍 No    |              | List of any strings                                            | A list of files that will trigger a build.                                                            |
| `archived`            | 👍 No    | false        | `true`, `false`                                                | Whether the repository is archived.                                                                   |
| `environments`        | 👍 No    | [discovered] | List of environment names, "development", "test", "production" | List of environment names. Discovered if omitted.                                                     |
| `fail_fast`           | 👍 No    | true         | `true`, `false`                                                | Whether all deployments should fail if one environment fails.                                         |
| `has_discussions`     | 👍 No    | false        | `true`, `false`                                                | Whether GitHub Discussions are enabled for the repository.                                            |
| `has_issues`          | 👍 No    | true         | `true`, `false`                                                | Whether GitHub Issues are enabled for the repository.                                                 |
| `has_projects`        | 👍 No    | false        | `true`, `false`                                                | Whether GitHub Projects are enabled.                                                                  |
| `has_wiki`            | 👍 No    | false        | `true`, `false`                                                | Whether the GitHub Wiki is enabled. Ideally, keep docs in the `docs/` directory.                      |
| `needs_todo_to_issue` | 👍 No    | false        | `true`, `false`                                                | If [TODO to Issue](https://github.com/marketplace/actions/todo-to-issue) is needed in this repo.      |
| `needs_tofu`          | 👍 No    | false        | `true`, `false`                                                | If OpenTofu is needed in this repo.                                                                   |
| `tofu_build_schedule` | 👍 No    |              | cron expression                                                | The time at which the OpenTofu build should run.                                                      |
| `app_build_schedule`  | 👍 No    |              | cron expression                                                | The time at which the application build should run.                                                   |
| `visibility`          | 👍 No    | `public`     | `public`, `private`                                            | Determines if the repository is public or private.                                                    |
| `tocgen`              | 👍 No    | `false`      | `true`, `false`                                                | If `true`, enables [tocgen](https://github.com/evoteum/tocgen/). You probably want this to be `true`. |


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

### Fixing Drift

OpenTofu runs every night at 23:00Z to detect and correct any drift that may have occurred during the day. This ensures that:

- Manual changes made to repositories are reverted to their defined state
- External API integrations remain properly configured
- Security settings and access controls stay aligned with specifications
- Repository settings consistently match their `repos.yml` definitions

This automated drift prevention means repository configurations are truly managed as code, ensuring that the `repos.yml` file remains the single source of truth for all repository settings.


> [!IMPORTANT]
> Any manual repository configuration changes you make will be reverted. Configure repositories using `repos.yml`.

### Style points

We try to avoid using OpenTofu `data` blocks. Yes, they are perfectly legitimate, however they can also tighten coupling
and introduce funky behaviour, such needing two applies to get the correct data. Wherever possible, please get
values directly from the resources.

## Contributing

Contributions are welcome!


## License

This project is licensed under the AGPL-3.0 License. See the [LICENSE](LICENSE) file for details.
