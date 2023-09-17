resource "aws_instance" "ec2_instance1" {
  ami                         = var.imagenes.redhat
  instance_type               = "t2.micro"
  count                       = 0
  key_name                    = aws_key_pair.key_class2.key_name
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  subnet_id                   = element(aws_subnet.subnets_public.*.id, count.index)
  associate_public_ip_address = true
  user_data                   = file("configure_apache.sh")
  tags = {
    Name = "ec2_Redhat"
  }
}

resource "aws_instance" "ec2_instance2" {
  ami                         = var.imagenes.windows
  instance_type               = "t2.micro"
  count                       = 0
  key_name                    = aws_key_pair.key_class2.key_name
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  subnet_id                   = aws_subnet.subnets_public[1].id
  associate_public_ip_address = true
  tags = {
    Name = "ec2_windows"
  }
}