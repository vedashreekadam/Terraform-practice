resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo.id

  tags =  {
    name = "${var.project}-igw"
  }
}