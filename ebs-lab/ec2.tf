data "aws_ssm_parameter" "al2023" {
    name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "vm" {
    ami = data.aws_ssm_parameter.al2023.value
    instance_type = "t3.micro"
        key_name = "vedaj-keypair"
      vpc_security_group_ids = [aws_security_group.ec2_sg.id]

      user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "ebs-lab-instance"
  }
}

resource "aws_ebs_volume" "data_volume" {
  availability_zone = aws_instance.vm.availability_zone
  size              = var.volume_size

  tags = {
    Name = "ebs-lab-volume"
  }
}

resource "aws_volume_attachment" "attach" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.data_volume.id
  instance_id = aws_instance.vm.id
}