resource "aws_subnet" "public_s1" {
  vpc_id = aws_vpc.demo.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.region}a"

  tags ={
    name = "${var.project}-public-subnet"
  }
}

resource "aws_subnet" "private_s2" {
    vpc_id = aws_vpc.demo.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "${var.region}a"

    tags ={
        name = "${var.project}-private-subnet"
    }
}