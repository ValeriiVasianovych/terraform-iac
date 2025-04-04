# This is unit 
variable "content" {}

resource "local_file" "file" {
  content  = var.content
  filename = "${path.module}/hello.txt"
}