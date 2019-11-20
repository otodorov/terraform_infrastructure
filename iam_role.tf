resource "aws_iam_role" "AmazonEC2ApplicationRole" {
  name = "AmazonEC2ApplicationRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "AmazonEC2ApplicationRole"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_attach_role" {
  role       = aws_iam_role.AmazonEC2ApplicationRole.name
  count      = length(var.ec2_attach_role)
  policy_arn = var.ec2_attach_role[count.index]
}

resource "aws_iam_instance_profile" "AmazonEC2ApplicationRole" {
  name = "AmazonEC2ApplicationRole"
  role = aws_iam_role.AmazonEC2ApplicationRole.name
}
