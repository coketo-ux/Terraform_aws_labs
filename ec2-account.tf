

# resource "aws_instance" "test" {
#   ami = "ami-0c55b159cbfafe1f0"
#   instance_type = "t2.micro"
# }

resource "aws_vpc" "main1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main1"
  }
}

