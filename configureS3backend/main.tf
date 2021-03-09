provider "aws" {
  region = "ap-southeast-2"
  profile = "deepak-terraform" 
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "deepak-ap-southeast-2-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "deepak-ap-southeast-2-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-southeast-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "deepak-ap-southeast-2-terraform-locks"
    encrypt        = true
  }
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}
