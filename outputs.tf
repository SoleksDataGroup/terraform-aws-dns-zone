output "zone_id" {
  description = "DNS Zone ID"
  value = data.aws_route53_zone.dns-zone[0].zone_id
}
