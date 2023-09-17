

resource "aws_key_pair" "key_class2" {
  key_name   = "class_key2"
  public_key = file("id_rsa.pub")

}
