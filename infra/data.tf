data "aws_route53_zone" "main" {
  name         = "lugeasy.com"
  private_zone = false
}
resource "aws_route53_zone" "main" {
  name = "lugeasy.com"
}
