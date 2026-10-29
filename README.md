DevOps Delivery Challenge

A Python web application demonstrating an automated DevOps workflow using Docker, GitHub Actions, SonarQube, Terraform, Ansible, and GitHub Container Registry (GHCR).

The project focuses on automated testing, code-quality analysis, container image publishing, infrastructure provisioning, and application deployment.

Project Objectives

Containerize a Python application using Docker.

Automate linting and automated tests with GitHub Actions.

Analyze code quality and test coverage using SonarQube.

Build and publish versioned Docker images to GitHub Container Registry.

Provision cloud infrastructure using Terraform.

Configure and deploy the application on an EC2 instance using Ansible.

Validate the deployment through an application health endpoint.

Document deployment evidence and troubleshooting decisions.

Technology Stack

Technology

Purpose

Python

Application development

Flask

Web application framework

pytest

Automated testing

pytest-cov

Test coverage reporting

Ruff

Python linting

Docker

Application containerization

Docker Compose

Local container orchestration

GitHub Actions

CI/CD automation

SonarQube Community Edition

Static analysis and quality gate

GitHub Container Registry

Container image storage

Terraform

Infrastructure as Code

Ansible

Server configuration and application deployment

AWS EC2

Application hosting

Architecture and Workflow

The project uses a CI/CD workflow that separates code validation from deployment.

1. Continuous Integration (CI)

The CI workflow runs when relevant application or infrastructure files are changed on the main branch, or when a pull request targeting main changes those files.

The pipeline performs the following steps:

Checks out the repository.

Sets up Python 3.12.

Installs project dependencies and development tools.

Runs Ruff to check Python code quality.

Runs pytest and generates a coverage report.

Uploads the coverage report as a workflow artifact.

Runs SonarQube analysis.

Checks the SonarQube Quality Gate result.

The SonarQube stage depends on the test job completing successfully.

2. Continuous Delivery (CD)

After a successful CI run caused by a push to main, the CD workflow:

Checks out the tested commit.

Creates a Docker image tag based on the commit SHA.

Authenticates to GitHub Container Registry.

Builds and publishes the Docker image.

Configures Ansible in the GitHub Actions runner.

Connects to the EC2 server over SSH.

Deploys the published image using the Ansible deployment playbook.

Checks the application's /health endpoint.

The deployment workflow is designed to run only when the corresponding CI workflow succeeds for a push event on main.

Application Endpoints

Application information

GET /

Returns application metadata, including its name and version.

Example response:

{
  "app": "devops-delivery-challenge",
  "version": "1.0.0"
}

Health check

GET /health

Returns the health status of the application.

Example response:

{
  "status": "healthy"
}

The health endpoint is used by the deployment workflow to verify that the application responds after deployment.

Running the Application Locally

Prerequisites

Python 3.12

Docker Desktop or Docker Engine

Git

Option 1: Run with Python

Clone the repository:

git clone https://github.com/ahmednabilsiam/devops-delivery-challenge.git
cd devops-delivery-challenge

Create and activate a virtual environment.

On Windows PowerShell:

python -m venv .venv
.\.venv\Scripts\Activate.ps1

On Linux or WSL:

python3 -m venv .venv
source .venv/bin/activate

Install the dependencies:

pip install -r requirements.txt

Run the application using the project's configured entry point. Check the application files for the exact startup command and required environment variables.

Option 2: Run with Docker Compose

From the repository root:

docker compose up --build -d

Inspect the running containers:

docker compose ps

Review application logs:

docker compose logs

Stop the local services:

docker compose down

Check docker-compose.yaml for the configured ports and service names before accessing the application.

Testing and Code Quality

Run the linter:

ruff check app tests

Run the test suite with coverage:

pytest --cov=app --cov-report=term-missing --cov-report=xml:coverage.xml

The CI workflow executes these checks automatically.

SonarQube Results

At the time the project evidence was captured:

Quality Gate: Passed

Test coverage: 90.9%

Code duplications: 0.0%

These are results from the recorded analysis, not a guarantee that future commits will produce the same results.

Infrastructure and Deployment

Terraform

Terraform configuration is maintained under the infra/ directory.

It is used to manage the AWS infrastructure required by the project, including the EC2 server and related networking resources.

Review the environment and module configuration before running Terraform commands. Check the execution plan carefully before applying changes, and destroy resources when they are no longer needed to avoid unnecessary AWS charges.

Ansible

Ansible configuration and playbooks are maintained under the ansible/ directory.

The deployment workflow uses Ansible to configure Docker on the target server and deploy the application container from GHCR.

The target inventory group must match the host group declared in the playbook.

Container Registry

Application images are published to GitHub Container Registry under:

ghcr.io/ahmednabilsiam/devops-delivery-challenge

The CD workflow tags images using the tested commit SHA, helping associate a deployed image with a specific revision of the source code.

Key Challenges and Solutions

1. Ansible Inventory and Deployment Target

Challenge: The deployment workflow must provide an inventory group that matches the group targeted by the Ansible playbook. A mismatch can prevent the intended hosts from receiving deployment tasks.

Solution: The temporary inventory generated by the CD workflow was aligned with the app_servers group used by the deployment playbook. The workflow was then validated through a successful deployment run.

Lesson learned: Inventory definitions, playbook host patterns, and deployment variables must remain consistent across local and CI/CD environments.

2. SSH Host Verification and Deployment Connectivity

Challenge: The GitHub Actions runner needs to connect to the EC2 server. SSH host verification and network access restrictions can prevent the runner from reaching the deployment stage.

Solution: SSH configuration was adjusted to handle host-key verification consistently, and the security-group and connectivity configuration was investigated during troubleshooting.

Lesson learned: Secure deployment requires correct SSH configuration and carefully scoped network access. SSH should not be exposed broadly to the internet simply to make a pipeline work.

Repository Structure

devops-delivery-challenge/
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── cd.yml
├── ansible/
│   ├── inventory/
│   ├── playbooks/
│   └── roles/
├── app/
├── infra/
├── tests/
├── docs/
│   ├── PROJECT_EVIDENCE.md
│   └── evidence/
├── Dockerfile
├── docker-compose.yaml
├── requirements.txt
├── sonar-project.properties
└── README.md

Some directories may contain additional configuration files and modules.

Project Evidence

Screenshots documenting CI/CD runs, SonarQube analysis, container publication, EC2 configuration, and application health checks are available in docs/PROJECT_EVIDENCE.md.

Security and Cost Considerations

Do not commit AWS access keys, private SSH keys, or SonarQube tokens.

Store CI/CD credentials in GitHub Actions secrets or use an appropriately configured identity-based authentication method.

Restrict inbound security-group rules to the minimum access required.

Avoid leaving development infrastructure running when it is no longer required.

Review Terraform plans before applying or destroying resources.

Verify that published container images do not contain secrets or sensitive configuration.

Current Scope and Limitations

The project demonstrates automated testing, static analysis, container image publication, and deployment with a health check.

Additional hardening and recovery tasks—such as restricting public application exposure, applying container security restrictions, deliberately testing a failed health check, and demonstrating rollback to a previous known-good image—should be considered complete only after they have been implemented and verified.

Author

Ahmed Nabil

GitHub: ahmednabilsiam