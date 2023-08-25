resource "aws_instance" "servers" {
  ami                    = var.AMI
  instance_type          = var.CPU
  vpc_security_group_ids = [var.MONGODB_CLUSTER_SG_ID]
  key_name               = var.KEY_NAME
  for_each               = local.data
  subnet_id              = each.value.sub_id
  tags = {
    Name = each.value.name
  }
}

# Create an IAM instance profile
resource "aws_iam_instance_profile" "control_machine_profile" {
  name = "control-machine-role-profile"
  role = var.ROLE_NAME
}

resource "aws_instance" "control-machine" {
  ami                    = var.AMI
  instance_type          = var.CPU
  vpc_security_group_ids = [var.CONTROL_MACHINE_SG_ID]
  key_name               = var.KEY_NAME
  subnet_id              = var.PRI_SUB_7_A_ID
  user_data              = filebase64("../module/EC2/config.sh")
  iam_instance_profile  = aws_iam_instance_profile.control_machine_profile.name
  tags = {
    Name = "control-machine"
  }
}

