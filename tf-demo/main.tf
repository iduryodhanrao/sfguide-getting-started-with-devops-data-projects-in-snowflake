terraform {
  required_providers {
    snowflake = {
      source = "snowflakedb/snowflake"
      version = "2.1.0"
    }
  }
}

locals {
  organization_name = "<your_org_name>"
  account_name      = "<your_account_name>"
  private_key_path  = "../.snowflake/RSA_KEY.p8"
}

provider "snowflake" {
    organization_name = local.organization_name
    account_name      = local.account_name
    user              = "SERVICE_USER"
    role              = "SYSADMIN"
    authenticator     = "SNOWFLAKE_JWT"
    private_key       = file(local.private_key_path)
}

resource "snowflake_database" "tf_db" {
  name    = "TF_DEMO_DB"
  comment = "Summit demo 2025"
}

resource "snowflake_warehouse" "tf_warehouse" {
  name = "TF_DEMO_WH"
}
