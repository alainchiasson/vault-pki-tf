resource "vault_mount" "test_org_v1_ica2_v1" {
 path                      = "ica2"
 type                      = "pki"
 description               = "PKI engine hosting intermediate CA2 v1 for test org"
 default_lease_ttl_seconds = local.default_1hr_in_sec
 max_lease_ttl_seconds     = local.default_1hr_in_sec
}

resource "vault_pki_secret_backend_intermediate_cert_request" "test_org_v1_ica2_v1" {
 depends_on   = [vault_mount.test_org_v1_ica2_v1]
 backend      = vault_mount.test_org_v1_ica2_v1.path
 type         = "internal"
 common_name  = "Intermediate CA2 v1 "
 key_type     = "rsa"
 key_bits     = "2048"
 ou           = "test org"
 organization = "test"
 country      = "US"
 locality     = "Bethesda"
 province     = "MD"
}

/*
resource "vault_pki_secret_backend_root_sign_intermediate" "test_org_v1_sign_ica2_v5_by_ica1_v1" {
 depends_on = [
   vault_pki_secret_backend_intermediate_cert_request.test_org_v1_ica2_v1,
 ]
 backend              = local.ica1_path
 csr                  = vault_pki_secret_backend_intermediate_cert_request.test_org_v1_ica2_v1.csr
 common_name          = "Intermediate CA2 v1.5"
 exclude_cn_from_sans = true
 ou                   = "test org"
 organization         = "test"
 country              = "US"
 locality             = "Bethesda"
 province             = "MD"
 max_path_length      = 1
 ttl                  = local.default_1hr_in_sec
}


resource "vault_pki_secret_backend_intermediate_set_signed" "test_org_v1_ica2_v5_signed_cert" {
 depends_on  = [vault_pki_secret_backend_root_sign_intermediate.test_org_v1_sign_ica2_v5_by_ica1_v1]
 backend     = vault_mount.test_org_v1_ica2_v1.path
 certificate = format("%s\n%s", vault_pki_secret_backend_root_sign_intermediate.test_org_v1_sign_ica2_v5_by_ica1_v1.certificate, file("../${path.module}/cacerts/test_org_v1_ica1_v1.crt"))
}

resource "vault_pki_secret_backend_root_sign_intermediate" "test_org_v1_sign_ica2_v2_by_ica1_v1" {
 depends_on = [
   vault_pki_secret_backend_intermediate_cert_request.test_org_v1_ica2_v1,
 ]
 backend              = local.ica1_path
 csr                  = vault_pki_secret_backend_intermediate_cert_request.test_org_v1_ica2_v1.csr
 common_name          = "Intermediate CA2 v1.2"
 exclude_cn_from_sans = true
 ou                   = "test org"
 organization         = "test"
 country              = "US"
 locality             = "Bethesda"
 province             = "MD"
 max_path_length      = 1
 ttl                  = local.default_1hr_in_sec
}


resource "vault_pki_secret_backend_intermediate_set_signed" "test_org_v1_ica2_v2_signed_cert" {
 depends_on  = [vault_pki_secret_backend_root_sign_intermediate.test_org_v1_sign_ica2_v2_by_ica1_v1]
 backend     = vault_mount.test_org_v1_ica2_v1.path
 certificate = format("%s\n%s", vault_pki_secret_backend_root_sign_intermediate.test_org_v1_sign_ica2_v2_by_ica1_v1.certificate, file("../${path.module}/cacerts/test_org_v1_ica1_v1.crt"))
}

*/

resource "vault_pki_secret_backend_root_sign_intermediate" "test_org_v1_sign_ica2_v3_by_ica1_v1" {
 depends_on = [
   vault_pki_secret_backend_intermediate_cert_request.test_org_v1_ica2_v1,
 ]
 backend              = local.ica1_path
 csr                  = vault_pki_secret_backend_intermediate_cert_request.test_org_v1_ica2_v1.csr
 common_name          = "Intermediate CA2 v1.3"
 exclude_cn_from_sans = true
 ou                   = "test org"
 organization         = "test"
 country              = "US"
 locality             = "Bethesda"
 province             = "MD"
 max_path_length      = 1
 ttl                  = local.default_1hr_in_sec
}


resource "vault_pki_secret_backend_intermediate_set_signed" "test_org_v1_ica2_v3_signed_cert" {
 depends_on  = [vault_pki_secret_backend_root_sign_intermediate.test_org_v1_sign_ica2_v3_by_ica1_v1]
 backend     = vault_mount.test_org_v1_ica2_v1.path
 certificate = format("%s\n%s", vault_pki_secret_backend_root_sign_intermediate.test_org_v1_sign_ica2_v3_by_ica1_v1.certificate, file("../${path.module}/cacerts/test_org_v1_ica1_v1.crt"))
}


resource "vault_pki_secret_backend_root_sign_intermediate" "test_org_v1_sign_ica2_v4_by_ica1_v1" {
 depends_on = [
   vault_pki_secret_backend_intermediate_cert_request.test_org_v1_ica2_v1,
 ]
 backend              = local.ica1_path
 csr                  = vault_pki_secret_backend_intermediate_cert_request.test_org_v1_ica2_v1.csr
 common_name          = "Intermediate CA2 v1.4"
 exclude_cn_from_sans = true
 ou                   = "test org"
 organization         = "test"
 country              = "US"
 locality             = "Bethesda"
 province             = "MD"
 max_path_length      = 1
 ttl                  = local.default_1hr_in_sec
}


resource "vault_pki_secret_backend_intermediate_set_signed" "test_org_v1_ica2_v4_signed_cert" {
 depends_on  = [vault_pki_secret_backend_root_sign_intermediate.test_org_v1_sign_ica2_v4_by_ica1_v1]
 backend     = vault_mount.test_org_v1_ica2_v1.path
 certificate = format("%s\n%s", vault_pki_secret_backend_root_sign_intermediate.test_org_v1_sign_ica2_v4_by_ica1_v1.certificate, file("../${path.module}/cacerts/test_org_v1_ica1_v1.crt"))
}


resource "vault_pki_secret_backend_config_issuers" "config" {
  backend                       = vault_pki_secret_backend_intermediate_set_signed.test_org_v1_ica2_v4_signed_cert.backend
//  default                       = vault_pki_secret_backend_intermediate_set_signed.test_org_v1_ica2_v4_signed_cert.imported_issuers[0]
  default = "b5081b57-83a5-9559-730e-e9c99e4e7f8e"
  default_follows_latest_issuer = true
}

/*
output "set_signed" {
  value = vault_pki_secret_backend_intermediate_set_signed.test_org_v1_ica2_v4_signed_cert
}
*/