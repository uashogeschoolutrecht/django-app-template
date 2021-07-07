# Django Template Repository

This project consists of a web application for a template project at the Hogeschool Utrecht.

## Modules

- [Source Code](./source/README.md): Django application code.
- [Infrastructure Configuration](./ansible/README.md): Ansible playbooks that configure the application environment for hosting the Django application.
- [Application Configuration](./config/README.md): Django application configuration files.

## Scripts

The `./scripts` directory holds operational scripts that can be used to deploy and manage a running instance of the application.

### Manual Deployment

You can deploy the application to an Ubuntu machine using the `./scripts/deploy.sh` script. This deploys the source artifact `source.tar.gz` and config files under `config/`.
You need to set the following environment variables:

```shell
export ENV=
export SSH_KEY_FILE=
export VAULT_PW_FILE=

./scripts/deploy_app.sh
./scripts/deploy_config.sh
```

#### Dry Run

You can validate your playbook tasks without making changes to the actual host by setting `DRY_RUN=true`.

```shell
export ENV=
export SSH_KEY_FILE=
export VAULT_PW_FILE=
export DRY_RUN=true

./scripts/deploy_app.sh
./scripts/deploy_config.sh
```

## GitHub Actions

GitHub actions are used to implement CI/CD pipelines for our Django app.

### Pull Request

You need to open a pull request in order to submit a change to the master branch. An automated pipeline verifies your code by running test suites and static code analysis tools. Then, the infrastructure configuration scripts are verified by executing "dry runs" against the actual environment.

### Automated Deployment

The application runs in two environments, `staging` and `production`. Every change that lands on master is deployed into the staging environment for testing. When we are ready to release a new version of the application, a GitHub release is created. The release is tagged and a deployment to production is triggered. The automated deployment is verified using lightweight smoke tests that make sure the application is up and ready to accept user requests.

#### Source artifact

The source artifact should be an archive in the root directory called `source.tar.gz`. This will be picked up by the deployment scripts and copied onto the target hosts.

#### Configuration artifact

The configuration artifact should be in a `config/<env>/` directory where `env` is the target environment for the configuration. The deployment scripts will copy the configuration onto the target hosts.
