# Todo List Web Application

Todo List is a web application based on Flask that allows you to add new notes and see your previous notes. The project utilizes Infrastructure as Code (IaC) using Terraform to deploy the infrastructure on AWS Cloud. The Terraform code installs Docker on the instance and clones the code from a GitHub repository. Then, the command `docker-compose up -d` is executed to start the application.

## Features

- Add new notes
- View previous notes
- Easy to use interface
- Deployed on AWS Cloud using Terraform

## Getting Started

To get started with Todo List, follow the instructions below.

### Prerequisites

- Terraform
- AWS account

### Installation

1. Clone the GitHub repository
2. Run `terraform init` to initialize Terraform
3. Run `terraform plan` to preview the resources that will be created
4. Run `terraform apply` to create the resources on AWS
5. Wait for Terraform to finish provisioning the resources
6. Open the application URL in your browser

## Technologies Used

- Flask
- Terraform
- Docker
- AWS

## Contributors

- John Doe
- Jane Smith
- Alex Johnson

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
