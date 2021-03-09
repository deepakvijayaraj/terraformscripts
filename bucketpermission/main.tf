provider "aws" {
  region = var.aws_region
  profile = "deepak-terraform" 
}

resource "aws_iam_user" "bucket_user" {
  name = var.iam_user_name
  tags = {}
}

resource "aws_iam_user_policy" "s3_user_policy_read" {
  count = length(var.bucket_folder_names_read) > 0 ? 1 : 0
  name = "${var.iam_user_name}-s3-read"
  user = aws_iam_user.bucket_user.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect: "Allow",
        Action: "s3:GetObject",
        Resource = [for bucket_foldername in var.bucket_folder_names_read : "arn:aws:s3:::${var.bucket_name}/${bucket_foldername}/*"]
      }
    ]
  })
}

resource "aws_iam_user_policy" "s3_user_policy_write" {
  count = length(var.bucket_folder_names_write) > 0 ? 1 : 0
  name = "${var.iam_user_name}-s3-write"
  user = aws_iam_user.bucket_user.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect: "Allow",
        Action: "s3:PutObject",
        Resource = [for bucket_foldername in var.bucket_folder_names_write : "arn:aws:s3:::${var.bucket_name}/${bucket_foldername}/*"]
      }
    ]
  })
}
