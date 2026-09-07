resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.project}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_s1.id

  tags = {
    Name = "${var.project}-nat-gw"
  }
}
