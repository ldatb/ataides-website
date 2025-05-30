##########
# Locals #
##########
locals {
  s3_origin_id   = "${var.domain_name}-origin"
}

#############
# S3 Bucket #
#############

resource "aws_s3_bucket" "this" {
    bucket = var.domain_name
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "this" {
    bucket = aws_s3_bucket.this.id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "404.html"
    }
}

resource "aws_s3_bucket_policy" "this" {
    bucket = aws_s3_bucket.this.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Sid = "PublicReadGetObject"
            Effect = "Allow"
            Principal = "*"
            Action = ["s3:GetObject"]
            Resource = ["${aws_s3_bucket.this.arn}/*"]
        }]
    })
}

###########################
# CloudFront Distribution #
###########################

resource "aws_cloudfront_distribution" "this" {
    enabled = true

    origin {
        origin_id = local.s3_origin_id
        domain_name = aws_s3_bucket_website_configuration.this.website_endpoint
        custom_origin_config {
            http_port = 80
            https_port = 443
            origin_protocol_policy = "http-only"
            origin_ssl_protocols   = ["TLSv1"]
        }
    }

    aliases = [var.domain_name, "www.${var.domain_name}"]

    default_cache_behavior {
        target_origin_id = local.s3_origin_id
        allowed_methods = ["GET", "HEAD"]
        cached_methods = ["GET", "HEAD"]

        forwarded_values {
            query_string = true

            cookies {
                forward = "all"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        default_ttl = 0
        min_ttl = 0
        max_ttl = 0
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }
    
    viewer_certificate {
        cloudfront_default_certificate = true
    }

    price_class = "PriceClass_200"
}

############
# Route 53 #
############

resource "aws_route53_zone" "this" {
    name = var.domain_name
}

resource "aws_route53_record" "root_domain" {
    zone_id = aws_route53_zone.this.zone_id
    name = var.domain_name
    type = "A"

    alias {
        name = aws_cloudfront_distribution.this.domain_name
        zone_id = aws_cloudfront_distribution.this.hosted_zone_id
        evaluate_target_health = false
    }
}
