resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.your_zone.id # Replace with your Route53 zone ID
  name    = "group2-urlshortener"         # Or "api" if you want api.group2-urlshortener.sctp-sandbox.com
  type    = "ALIAS"
  ttl     = "300" # Example TTL

  alias {
    name                   = aws_api_gateway_domain_name.shortener.regional_domain_name # Important!
    zone_id                = aws_api_gateway_domain_name.shortener.regional_zone_id     # Important!
    evaluate_target_health = true
  }
}


resource "aws_api_gateway_domain_name" "shortener" {
  domain_name              = "group2-urlshortener.sctp-sandbox.com"
  regional_certificate_arn = "" # ACM Cert for your domain

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "shortener" {}
