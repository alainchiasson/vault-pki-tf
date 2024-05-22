provider "vault" {}

locals {
 default_3y_in_sec   = 94608000
 default_1y_in_sec   = 31536000
 default_1hr_in_sec = 3600

 issuer_sart_dates  = [
    "2024-05-17TT00:00:00Z",
    "2025-05-17TT00:00:00Z",
    "2026-05-17TT00:00:00Z",
    "2027-05-17TT00:00:00Z",
    "2028-05-17TT00:00:00Z"
 ]
}


resource "vault_pki_secret_backend_root_sign_intermediate" "test_org_v1_sign_ica2_v6_by_ica1_v1" {
 depends_on = [
   vault_pki_secret_backend_intermediate_cert_request.test_org_v1_ica2_v1,
 ]
 backend              = local.ica1_path
 csr                  = vault_pki_secret_backend_intermediate_cert_request.test_org_v1_ica2_v1.csr
 common_name          = "Intermediate CA2 v1.6"
 exclude_cn_from_sans = true
 ou                   = "test org"
 organization         = "test"
 country              = "US"
 locality             = "Bethesda"
 province             = "MD"
 max_path_length      = 1
 ttl                  = local.default_15min_in_sec
}


resource "vault_pki_secret_backend_intermediate_set_signed" "test_org_v1_ica2_v6_signed_cert" {
 depends_on  = [vault_pki_secret_backend_root_sign_intermediate.test_org_v1_sign_ica2_v6_by_ica1_v1]
 backend     = vault_mount.test_org_v1_ica2_v1.path
 certificate = format("%s\n%s", vault_pki_secret_backend_root_sign_intermediate.test_org_v1_sign_ica2_v6_by_ica1_v1.certificate, file("../${path.module}/cacerts/test_org_v1_ica1_v1.crt"))
}
