# estate-repos

**estate-repos** is a repository designed to automate the creation and management of repositories within the [evoteum](https://github.com/evoteum) organization. It leverages [OpenTofu](https://opentofu.org/) to apply infrastructure-as-code principles, enabling seamless repository provisioning and configuration.

## Features

- **Automated Repository Creation**: Simply add the repository name, description, and any required attributes to `repos.yaml`.
- **Consistent Configuration**: Ensures all repositories follow organizational standards.
- **Scalable and Flexible**: Easily add and modify repositories as needed.


## Usage
### Creating repos

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/evoteum/estate-repos.git
   cd estate-repos
   ```

2. **Define Repositories**:
   - Open `repos.yaml` and add new repositories with attributes like:
     ```yaml
     - name: my-new-repo
       description: "A new project for evoteum."
       visibility: private
       topics:
         - devops
         - automation
     ```

3. **Push the change**

After a few seconds, the new repository will be created in the evoteum organization.

### Archiving repos

We do not delete repositories, as they may contain valuable information, so do not remove repos from repos.yaml. Instead, archive them by simply adding `archived: true` to the repository definition in `repos.yaml`.

## Repository Variables in repos.yaml

Each repository entry in repos.yaml can include the following variables:

| Parameter         | Required | Default  | Description                                                                                        |
|-------------------|----------|----------|----------------------------------------------------------------------------------------------------|
| key               | ❗ Yes    |          | The name of the repository.                                                                        |
| `description`     | ❗ Yes    |          | A brief description of the repository.                                                             |
| `visibility`      | 👍 No    | `public` | Determines if the repository is public or private. Should only be changed if absolutely necessary. |
| `homepage_url`    | 👍 No    |          | The URL of the project's homepage.                                                                 |
| `has_issues`      | 👍 No    | true     | Whether GitHub Issues are enabled for the repository.                                              |
| `has_discussions` | 👍 No    | false    | Whether GitHub Discussions are enabled for the repository.                                         |
| `has_projects`    | 👍 No    | false    | Whether GitHub Projects are enabled.                                                               |
| `has_wiki`        | 👍 No    | false    | Whether the GitHub Wiki is enabled.                                                                |
| `topics`          | 👍 No    |          | A list of topics associated with the repository.                                                   |
| `archived`        | 👍 No    | false    | Whether the repository is archived.                                                                |


## Repository Structure

- `.github/workflows/` - CI/CD workflows for automation.
- `tofu/` - Contains OpenTofu configuration files and modules.
- `repos.yaml` - YAML file defining repositories to be created.
- `LICENSE` - License information for the project.
- `README.md` - Documentation for using the repository.

## Contributing

Contributions are welcome! To propose changes:
1. Fork this repository.
2. Modify `repos.yaml` or other relevant files.
3. Submit a pull request.

## License

This project is licensed under the AGPL-3.0 License. See the [LICENSE](LICENSE) file for details.
