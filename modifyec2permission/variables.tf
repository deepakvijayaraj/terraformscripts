variable "aws_region" {
	description = "e.g. eu-north-1, us-east-1"
	default = "ap-southeast-2"
}

variable "iam_user_name" {
	description = "name given to IAM user"
	default = "iam-user"
    type = string
}

variable "datefrom" {
	description = "start date for permission"
    type = string
}

variable "dateto" {
	description = "end date for permission"
    type = string
}



