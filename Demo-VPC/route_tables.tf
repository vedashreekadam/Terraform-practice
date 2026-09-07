resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.demo.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags =  {
    name = "${var.project}-public-rt"
  }

}

resource "aws_route_table_association" "public-assoc" {
    subnet_id = aws_subnet.public_s1.id
    route_table_id = aws_route_table.public_rt.id
  
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.demo.id

  tags = {
    name = "${var.project}-private-rt"
  }
}

resource "aws_route_table_association" "private-rt" {
  subnet_id = aws_subnet.private_s2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route" "private_default_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}
