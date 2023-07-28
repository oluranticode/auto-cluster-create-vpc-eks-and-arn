resource "aws_iam_role" "sso_role" {
  name               = "MySSORole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::326355388919:saml-provider/AWSSSO_24586a6da6d315c7_DO_NOT_DELETE"
      },
      "Action": [
        "sts:AssumeRoleWithSAML",
        "sts:TagSession"
      ],
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.aws.amazon.com/saml"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy" "sso_policy" {
  name   = "MySSOPolicy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "sso_attachment" {
  role       = aws_iam_role.sso_role.name
  policy_arn = aws_iam_policy.sso_policy.arn
}
