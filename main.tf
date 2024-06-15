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
  count = length(var.zone_rrs)

  zone_id = data.aws_route53_zone.dns-zone[0].zone_id

  name = "${var.zone_records[count.index]}.name"
  ttl = "${var.zone_records[count.index]}.ttl"
  type = "${var.zone_records[count.index]}.type"
  records = "${var.zone_records[count.index]}.records"
}
