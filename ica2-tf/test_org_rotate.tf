
resource "vault_pki_secret_backend_root_sign_intermediate" "test_org_v1_by_ica1_v1_sign" {

 for_each = toset(local.active_issuer) 


 backend              = local.ica1_path
 csr                  = vault_pki_secret_backend_intermediate_cert_request.test_org_v1_ica2_v1.csr
 common_name          = "Intermediate CA2 ${each.key}"
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

 for_each = toset(local.active_issuer) 

 backend     = vault_mount.test_org_v1_ica2_v1.path
 certificate = format("%s\n%s", vault_pki_secret_backend_root_sign_intermediate.test_org_v1_by_ica1_v1_sign[each.value].certificate, file("../${path.module}/cacerts/test_org_v1_ica1_v1.crt"))
}
