resource "aws_key_pair" "vedas_key" {
  key_name   = "vedas-key"
  public_key = file("C:/ssh-key/vedaj-keypair.pub")
}
