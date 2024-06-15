// Module name: DNS Zone
// Provider name: AWS
//

variable "zone_vpc_id" {
  description = "VPC ID associated with the zone"
  type = string
  default = ""
}

variable "zone_name" {
  description = "Name of DNS Zone"
  type = string
  default = ""
}

variable "zone_type" {
  description = "Type of DNS Zone"
  type = string
  default = "private"
}

variable "zone_rrs" {
  description  = "DNS Zone resource records"
  type = list(object({
    name = string
    type = string
    ttl = optional(number)
    data = list(string)
  }))
  default = null
}
