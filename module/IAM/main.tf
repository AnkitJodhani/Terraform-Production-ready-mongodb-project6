
# Create an IAM role
resource "aws_iam_role" "control_machine" {
  name = "S3-and-secManger-access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}



resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.control_machine.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

resource "aws_iam_role_policy_attachment" "secret_manager_access" {
  role       = aws_iam_role.control_machine.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}
resource "aws_iam_role_policy_attachment" "CloudWatchAgent" {
  role       = aws_iam_role.control_machine.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}



