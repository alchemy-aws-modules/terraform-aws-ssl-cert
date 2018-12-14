variable "dns_name" {
  description = "The DNS name you want a cert for."
}

variable "dns_zone_id" {
  description = "The ZONEID of the zone in Route 53, for the dns_name."
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "${var.dns_name}"
  validation_method = "DNS"
}
 
resource "aws_route53_record" "cert_validation_dns_record" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type    = "CNAME"
  zone_id = "${var.dns_zone_id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}
 
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"]
}

output "cert_arn" {
	value = "${aws_acm_certificate.cert.arn}"
}
