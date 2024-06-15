data "aws_route53_zone" "dns-zone" {
  count        = var.zone_name == null ? 0 : 1
  name         = var.zone_name
  private_zone = var.zone_type == "private" ? true : false
}

resource "aws_route53_zone_association" "dns-zone-assoc" {
  count = var.zone_type == "private" ? 1 : 0
  zone_id = data.aws_route53_zone.dns-zone[0].zone_id
  vpc_id  = var.zone_vpc_id
}

resource "aws_route53_record" "dns-zone-rrs" {
  for_each = {
    for rr in var.zone_rrs: rr.name => rr...
  }
  zone_id = data.aws_route53_zone.dns-zone[0].zone_id

  name = each.value.name
  type = each.value.type
  ttl = each.value.ttl
  records = each.value.data
}
