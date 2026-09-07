resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = aws_vpc.demo.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.public_rt.id,
    aws_route_table.private_rt.id
  ]

  tags = {
    Name = "${var.project}-s3-endpoint"
  }
}
