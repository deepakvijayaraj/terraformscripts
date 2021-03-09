variable "aws_region" {
	description = "e.g. eu-north-1, us-east-1"
	default = "ap-southeast-2"
}

variable "bucket_name" {
	description = "your-bucket-name"
	default = "product-inventory"
}

variable "accountid" {
	description = "AWS Account to be used to setup IAM"
	default = "1234567890"
}

variable "bucket_folder_names_write" {
	description = "list of your bucket folder names that the user can upload to"
	type = list(string)
}

variable "bucket_folder_names_read" {
	description = "list of your bucket folder names that the user can read"
	type = list(string)
}

variable "iam_user_name" {
	description = "name given to IAM user"
	default = "bucket-user"
    type = string
}




