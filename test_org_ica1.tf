resource "vault_mount" "test_org_v1_ica1_v1" {
 path                      = "ica1"
 type                      = "pki"
 description               = "PKI engine hosting intermediate CA1 v1 for test org"
 default_lease_ttl_seconds = local.default_1hr_in_sec
 max_lease_ttl_seconds     = local.default_3y_in_sec
}


resource "vault_pki_secret_backend_intermediate_cert_request" "test_org_v1_ica1_v1" {
 depends_on   = [vault_mount.test_org_v1_ica1_v1]
 backend      = vault_mount.test_org_v1_ica1_v1.path
 type         = "internal"
 common_name  = "Intermediate CA1"
 key_type     = "rsa"
 key_bits     = "2048"
 ou           = "test org"
 organization = "test"
 country      = "US"
 locality     = "Bethesda"
 province     = "MD"
}


data "vault_pki_secret_backend_issuers" "test_org_v1_ica1_v1" {
    backend     = vault_pki_secret_backend_intermediate_cert_request.test_org_v1_ica1_v1.backend
}

resource "vault_pki_secret_backend_intermediate_set_signed" "test_org_v1_ica1_v1_signed_cert" {
 depends_on   = [vault_mount.test_org_v1_ica1_v1]
 backend      = vault_mount.test_org_v1_ica1_v1.path

 certificate = file("${path.module}/cacerts/test_org_v1_ica1_v1.crt")
}

resource "vault_pki_secret_backend_issuer" "test_org_v1_ica1_v1" {
  backend     = data.vault_pki_secret_backend_issuers.test_org_v1_ica1_v1.backend
  issuer_ref  = data.vault_pki_secret_backend_issuers.test_org_v1_ica1_v1.keys[0]
  issuer_name = "ICA-01-A"
}


data "vault_pki_secret_backend_issuer" "ica1_issuer" {
    
    for_each = toset(data.vault_pki_secret_backend_issuers.test_org_v1_ica1_v1.keys)

    backend = data.vault_pki_secret_backend_issuers.test_org_v1_ica1_v1.backend
    issuer_ref = each.value
}

/*
*/