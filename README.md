#Usage

dns_name is the name you need a cert for.
dns_zone_id is the zone you need it requested for in Route 53.

```
module "cert" {
  source          = "github.com/alchemy-aws-modules/terraform-aws-ssl-cert"
  dns_name        = "${var.dns_name}"
  dns_zone_id     = "${var.dns_zone_id}"
}
```
