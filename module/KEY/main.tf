resource "aws_key_pair" "key" {
    key_name = "controller"
    public_key = file("../module/KEY/controller.pub")
}

