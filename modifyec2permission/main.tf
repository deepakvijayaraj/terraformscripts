provider "aws" {
  region = var.aws_region
  profile = "deepak-terraform" 
}

data "aws_iam_user" "ec2_user" {
  user_name = var.iam_user_name
}

resource "aws_iam_user_policy" "ec2_start_stop" {
  name = "${var.iam_user_name}-ec2-start-stop"
  user = data.aws_iam_user.ec2_user.user_name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "StartStopIfTags",
            "Effect": "Allow",
            "Action": [
                "ec2:StartInstances",
                "ec2:StopInstances",
                "ec2:DescribeTags"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "ec2:ResourceTag/Type": "back-office",
                    "ec2:ResourceTag/Env": "prd"
                },
                "DateGreaterThan": {
                    "aws:CurrentTime": "2021-03-01T00:00:00Z"
                },
                "DateLessThan": {
                    "aws:CurrentTime": "2021-03-04T00:00:00Z"
                }
            }
        }
    ]
}
EOF
}
