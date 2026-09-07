data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "public_ec2" {
  ami           = data.aws_ssm_parameter.al2023.value
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_s1.id
  security_groups = [aws_security_group.public_sg.id]
  key_name = aws_key_pair.vedas_key.key_name


  tags = {
    Name = "${var.project}-public-ec2"
  }
}

resource "aws_instance" "private_ec2" {
  ami           = data.aws_ssm_parameter.al2023.value
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private_s2.id
  security_groups = [aws_security_group.private_sg.id]
  key_name = aws_key_pair.vedas_key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "${var.project}-private-ec2"
  }
}
