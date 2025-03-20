# Define the AWS provider
provider "aws" {
  region = "us-east-1"  # Change to your preferred AWS region
}

# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-145cl"  # Change to a globally unique name

  tags = {
    Name        = "MyS3Bucket" # Change to your preferred name tag
    Environment = "Dev"
  }
}
