output "public_ec2_ip" {
  value = aws_instance.streamlit.public_ip
}