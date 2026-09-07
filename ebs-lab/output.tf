output "instance_public_ip" {
  value = aws_instance.vm.public_ip
}

output "volume_id" {
  value = aws_ebs_volume.data_volume.id
}
