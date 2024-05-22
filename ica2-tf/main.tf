provider "vault" {}

locals {
 default_3y_in_sec   = 94608000
 default_1y_in_sec   = 31536000
 default_1hr_in_sec  = 3600
 default_15min_in_sec  = 60 * 15

 ica1_path           = "ica1"

 issuer_start_dates  = [
    "2024-05-17T00:00:00Z",
    "2024-05-18T00:00:00Z",
    "2024-05-19T00:00:00Z",
    "2027-05-17T00:00:00Z",
    "2028-05-17T00:00:00Z"
 ]

# count = var.include_ec2_instance ? 1 : 0

 active_issuer = [ for s in local.issuer_start_dates : split("T", s)[0] if timecmp(s, plantimestamp()) < 0 ]
 last_issuer = reverse(keys(tomap( { for s in local.active_issuer: s => s} )))[0]
}

output "active_issuer_tuple" {
    value = local.active_issuer
}

output "last_issuer" {
    value = local.last_issuer
}


