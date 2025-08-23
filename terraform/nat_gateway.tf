resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "NAT EIP"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "NAT Gateway"
  }

  depends_on = [aws_internet_gateway.main_igw]
}