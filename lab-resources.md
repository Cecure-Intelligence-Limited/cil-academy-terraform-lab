# Terraform Lab Resources - Commands, Links, etc.
This file contains a listing of the URLs and commands used in the lab exercises.

## Links
- Terraform downloads page: https://www.terraform.io/downloads.html
- HashiCorp’s "Install Terraform" page: https://developer.hashicorp.com/terraform/install
- AWS CLI download page: https://aws.amazon.com/cli/

## Commands
- `wmic os get osarchitecture` \
Run this command in Windows Command Prompt if you are not sure of the architecture of your Windows OS (32 vs 64 bits)

- `setx PATH "%PATH%;C:\terraform" /M` \
Remember to update the "C:\terraform" path to the correct path where your executable is located

- `aws --version` \
View the AWS CLI version and also verify it is installed and working correctly

- `aws configure` \
Configure your AWS CLI with AWS Access Credentials. This enables you to set the necessary permissions for resources to be created in the target AWS account later.

- `type "%USERPROFILE%\.aws\credentials"` \
Use in Windows Command Prompt to view the AWS credentials file.

- `Get-Content -Path "$env:USERPROFILE\.aws\credentials"` \
Use in Windows PowerShell to view the AWS credentials file.

- `cat ~/.aws/credentials` \
Use in macOS or Linux shell to view the AWS credentials file.

- `aws s3 ls` \
View a listing of all S3 buckets in the AWS account and verify the S3 Bucket was successfully created.


## Key Terraform Commands
- `terraform init` \
Prepares the working directory

- `terraform validate` \
checks for errors

- `terraform plan` \
Shows what Terraform will do

- `terraform apply -auto-approve` \
Applies the changes

- `terraform destroy -auto-approve` \
Cleans up resources

- `terraform --version` \
view your version and verify terraform is correctly installed


### End of Listing
---