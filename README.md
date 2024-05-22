# Vault managed PKI via terraform

this is a mashup of two things : 

- This blog post ( for the external root ) : https://www.hashicorp.com/blog/code-signing-with-hashicorp-vault-and-github-actions
- This tutorial on setting up PKI with an external root : https://developer.hashicorp.com/vault/tutorials/secrets-management/pki-engine-external-ca

# Modified Steps

generate a root ca

    bash root-ca/generate

Start server 

    vault server -dev -dev-root-token-id root

Run Terraform to create endpoint

    terraform init
    terraform apply

Extract, sign and create chain.

    bash root-ca/sign

Now modify terraform to upload the chain

    terraform apply

# Note 

This code creates the stack gradually, but we also build up the code. We need to split it in 2 or 3 parts: 

1. Generate ICA1 - and set cert if Cert is present. ( instead of manually adding code.)
2. For ICA2, Get ICA1 as data, insterad of resource.
3. For Roles - do the same, read as DATA. 

# These were the original steps 

terraform show -json | jq '.values["root_module"]["resources"][].values.csr' -r | grep -v null > csr/Test_Org_v1_ICA1_v1.csr

Now create the Certificate

    bash root-ca/sign

Create the Chain 

    cat crt/Test_Org_v1_ICA1_v1.pem crt/Testing_Root.crt > cacerts/test_org_v1_ica1_v1.crt


