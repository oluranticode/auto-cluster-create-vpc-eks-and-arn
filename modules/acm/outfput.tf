## outputs
output "acm_certificate_arn" {
  description = "arn of acm certificate"
  value       = aws_acm_certificate.acm_cert.arn
}

output "acm_certificate_dns_validation_record" {
  description = "record which is used to validate acm certificate"
  value       = aws_route53_record.record[var.domain_name].name
}