// Create subnet
resource "aws_subnet" "sub" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_block

  tags = merge(var.tags, {
    Name = var.subnet_name
  })
}

// Associate subnet to route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.sub.id
  route_table_id = aws_route_table.rt.id
}