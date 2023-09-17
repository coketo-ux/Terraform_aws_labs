resource "aws_vpc" "main1" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "main1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main1.id
  tags = {
    Name = "Internet Gateway"
  }
}



resource "aws_subnet" "subnets_public" {
  vpc_id            = aws_vpc.main1.id
  count             = length(data.aws_availability_zones.azs.names)
  cidr_block        = element(var.public_subnets, count.index)
  availability_zone = element(data.aws_availability_zones.azs.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_public_${count.index}+1"
  }
}

resource "aws_subnet" "subnets_private" {
  vpc_id            = aws_vpc.main1.id
  count             = length(data.aws_availability_zones.azs.names)
  cidr_block        = element(var.private_subnet, count.index)
  availability_zone = element(data.aws_availability_zones.azs.names, count.index)
  tags = {
    Name = "subnet_private_${count.index}"

  }
}



resource "aws_route_table" "public_route_table" {
  count  = 3
  vpc_id = aws_vpc.main1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = 3
  subnet_id      = element(aws_subnet.subnets_public.*.id, count.index)
  route_table_id = element(aws_route_table.public_route_table.*.id, count.index)
}


# SECURITY GROUPS

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main1.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.main1.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_http"
  }
}
