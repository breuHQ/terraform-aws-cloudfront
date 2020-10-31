resource aws_cloudfront_distribution default {
  origin {
    domain_name = var.bucket.website_endpoint
    origin_id   = "s3-${var.bucket.bucket}"

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1.2",
        "TLSv1.1",
        "TLSv1",
      ]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.default_root_object
  aliases             = [var.domain_name]

  default_cache_behavior {
    allowed_methods = [
      "GET",
      "DELETE",
      "HEAD",
      "POST",
      "PATCH",
      "PUT",
      "OPTIONS"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    target_origin_id = "s3-${var.bucket.bucket}"

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = var.lambda_arn
      include_body = true
    }

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = "sni-only"
  }

}

data aws_route53_zone default {
  name = var.zone_name
}


resource aws_route53_record default {
  zone_id = data.aws_route53_zone.default.zone_id
  name    = var.domain_name
  type    = var.record_type

  alias {
    name                   = aws_cloudfront_distribution.default.domain_name
    zone_id                = aws_cloudfront_distribution.default.hosted_zone_id
    evaluate_target_health = false
  }
}
