resource "aws_acm_certificate" "cert" {
  private_key       = file("./certificates/${var.private_key}")
  certificate_body  = file("./certificates/${var.certificate_body}")
  certificate_chain = file("./certificates/${var.certificate_chain}")
}
