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

resource "aws_acm_certificate" "cert" {
  domain_name       = "group2-urlshortener.sctp-sandbox.com" # Your domain name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# Route53 Zone (If you don't have it already)
resource "aws_route53_zone" "your_zone" {
  name = "sctp-sandbox.com" # Your domain
}

resource "aws_acm_certificate_validation" "example_validation_complete" {
  certificate_arn = aws_acm_certificate.example.arn

  # Depends on the DNS records being created
  depends_on = [aws_route53_record.example_validation]
}

resource "aws_api_gateway_domain_name" "shortener" {
  domain_name              = "group2-urlshortener.sctp-sandbox.com"
  regional_certificate_arn = "cert" # ACM Cert for your domain

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "shortener" {
  api_id      = aws_api_gateway_rest_api.shortener_api.id
  stage_name  = aws_api_gateway_deployment.shortener_deployment.stage_name
  domain_name = aws_api_gateway_domain_name.shortener.domain_name
  base_path   = "(none)" # Maps the root path.  Use "v1" for api.example.com/v1, etc.

}
