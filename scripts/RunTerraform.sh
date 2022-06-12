#!/usr/bin/env bash
###########################################
# Name: RunTerraform.sh
# Purpose: It is the main script that starts terrform infra build process. It is a wrapper script to terraform binary in
#          which we can perform various checks before actually executing terraform binary.
# Version
# -----------------------------
# S.No | Version | Updated By | Updated On | Comments
# 1.   | 0.1     | Shailender | 30/05/2022 | Created RunTerraform.sh script
# 2.   |         |            |            |
#
###########################################
# More detailed Purpose:
# ----------------------
# Sets up the Remote State for Terraform, runs terraform get -update and terraform plan
# Expects Azure credentials to be setup
# Expects path to this script to be in your path
#
# Backend settings are calculated from the VNET/app terraform.tfvars OR
# can be included in backend.tf if using terraform 0.9 or higher.
# To use a complete backend.tf, call
# INIT_METHOD=backend.tf RunTerraform.sh
#
# To initialize terraform only (and not run update/plan), call
# RunTerraform.sh --init-only
GREEN=`tput setaf 2`  #Green
NC=`tput sgr0` # No Color
# Get this script name and the location of vnet/terraform.tfvars for this app
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo -e "${GREEN}-----------------------------------------------------------------------------------------"
echo -e "** ZB Infrastructure as Code managed by Shailender Singh for Azure Cloud Resources  **"
echo -e "--------------------------------------------------------------------------------------------${NC}"
echo "$(basename $0) running:"
echo "-----------------------"
echo "  SCRIPT DIR          = $script_dir"
echo "  PWD                 = $PWD"

# Get common functions
. "$script_dir/functions.sh"

# Initialize common variables
echo
initBackendSettingsVars

# Run terraform remote config or terraform init depending on version of
# terraform, making this script and code mostly backwards compatible
# Those running 0.9 or higher should just have this backend.tf file
# if using VPC/app defined settings
#
# This script attempts to determine which backend.tf file you are using, but you can
# force using settings from backend.tf by setting INIT_METHOD=backend.tf,

terraform_version=$(terraform version | grep -Eo "[0-9.]+$" | head -n 1)

echo
if [ $(semver compare $terraform_version 0.12.0) == "-1" ] ; then
    echo "Calling terraform remote config for Terraform v${terraform_version}:"
    echo "Old way logic, but in our case we are using latest code version!"
else
  echo "${GREEN}** Terraform output starts from here for Terraform version [v${terraform_version}] **${NC}"
  if [[ "$INIT_METHOD" == "backend.tf" ]] ||
     [[ -f backend.tf && ! -z "$(prop bucket backend.tf)" ]]; then
      #echo  -e "1. storage_account_name=$storage_account_name \n container_name=$blob_container_name \n key=$state_file"
      terraform init -no-color
    else
      # Currently we are just testing this codd base and will update vault names later.
      ###echo  -e "2. storage_account_name=$storage_account_name \n container_name=$blob_container_name \n key=$state_file"

      terraform init -no-color \
          -backend-config="storage_account_name=$storage_account_name" \
          -backend-config="container_name=$blob_container_name" \
          -backend-config="key=$state_file" \
          -backend-config="access_key=$(az keyvault secret show --name tfstate-storage-key --vault-name devzbprojecta-kv --query value -o tsv)"
          ARM_ACCESS_KEY=$(az keyvault secret show --name tfstate-storage-key --vault-name devzbprojecta-kv --query value -o tsv)
          export ARM_ACCESS_KEY
          #-backend-config="key=283c6862-f3c8-4296-83d4-72e662338850/southindia/vnet-dev/app/projecta/servicea/az-storage/terraform.tfstate" \
          #-backend-config="key=$state_file" \
#          -backend-config="region=$azure_region"

    fi
fi

if [[ "$1" == "--init-only" ]]; then
  exit
fi

# Do the real work
echo

###echo " -- Access Key for debugging:$ARM_ACCESS_KEY"
echo "Running terraform get -update and terraform plan $@"
terraform get -no-color -update && terraform plan "$@"
