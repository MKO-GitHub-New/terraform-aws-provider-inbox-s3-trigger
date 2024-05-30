resource "aws_instance" "vpn" {
  instance_type          = var.instance_type
  ami                    = var.ami
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.vpc_security_group_ids]
  iam_instance_profile   = aws_iam_instance_profile.vpn.name
  key_name               = var.key_name
  source_dest_check      = false
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    encrypted   = var.storage_encrypted
    iops        = var.iops
  }

  tags = {
    Name        = "${var.environment}-vpn"
    role        = "vpn"
    owner       = "terraform"
    environment = var.environment
  }
}

resource "aws_iam_role" "vpn" {
  name = "${var.environment}-vpn"

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

}

resource "aws_iam_role_policy_attachment" "default" {
  count      = length(var.policy_attachments)
  role       = aws_iam_role.vpn.name
  policy_arn = element(var.policy_attachments, count.index)
}

resource "aws_iam_instance_profile" "vpn" {
  name = "${var.environment}-vpn"
  role = aws_iam_role.vpn.name
}