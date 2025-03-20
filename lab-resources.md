# Terraform Lab Resources - Commands, Links, etc.

## Links
- Terraform downloads page: https://www.terraform.io/downloads.html

## Commands
- *`wmic os get osarchitecture`* \
Run this command in Windows Command Prompt if you are not sure of the architecture of your Windows OS (32 vs 64 bits)

- `setx PATH "%PATH%;C:\terraform" /M` \
Remember to update the "C:\terraform" path to the correct path where your executable is located


## Key Terraform Commands
- terraform init \
Prepares the working directory
- terraform validate \
checks for errors
- terraform plan \
Shows what Terraform will do
- terraform apply \
Applies the changes
- terraform destroy \
Cleans up resources
- terraform --version \
view your version and verify terraform is correctly installed
