resource "aws_route53_record" "www" {}

resource "aws_api_gateway_domain_name" "shortener" {
  domain_name              = "group2-urlshortener.sctp-sandbox.com"
  regional_certificate_arn = "" # ACM Cert for your domain

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "shortener" {}
