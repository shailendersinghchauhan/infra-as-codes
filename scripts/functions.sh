GREEN=`tput setaf 2`  #Green
NC=`tput sgr0` # No Color
# Purpose: Common functions to be included in other scripts
####################
# Perform a terraform state move ONLY IF the state exists
function tfStateMove {
  # Sanity check
  terraform state list | grep -q "${1}"
  if [ $? -eq 0 ] ; then
     terraform state mv "${1}" "${2}"
  fi
}

# Get a property from terraform.tfvars
function prop {
    grep "${1}" ${2}|cut -d'=' -f2 | tr -d '"' | tr -d ' '
}

# Find a directory named "VNET" in this dir or any parent dir
# The "find" command will output the path
function findVNET {
    path=$1
    shift 1
    while [[ "$path" != "/" ]];
    do
        find "$path" -maxdepth 1 -mindepth 1 -iname "VNET"
        cd ..
        path=$PWD
    done
}

# Find and show the VNET TF variables
function initVNETTFVars {
  echo "${GREEN}** TF VNET info:**"
  echo "-------------------${NC}"
  VNET_PATH=$(findVNET $PWD)
  echo "  VNET DIR             = $VNET_PATH"

  VNET_VARS="${VNET_PATH}/terraform.tfvars"
  echo "  VNET TERRAFORM VARS  = $VNET_VARS"
}

# Find and set Backend Settings variables
function initBackendSettingsVars {
  if [[ "$INIT_METHOD" == "backend.tf" ]] ||
     [[ -f backend.tf && ! -z "$(prop bucket backend.tf)" ]]; then
    echo
    echo "Using backend.tf for terraform init"
  else
    initVNETTFVars

    # Get the backend settings based on VNET and this app
    environment_name=$(prop 'environment_name' $VNET_VARS)
    product="$(prop 'product' $VNET_VARS)"
    project="$(prop 'project' $VNET_VARS)"
    service_name="$(prop 'service_name' $VNET_VARS)"
    component="$(prop 'component' $VNET_VARS)"
    azure_region="$(prop 'azure_region' $VNET_VARS)"
    azure_short_region="$(prop 'azure_short_region' $VNET_VARS)"

    storage_account_name="$(prop 'storage_account_name' $VNET_VARS)"
    blob_container_name="$(prop 'container_name' $VNET_VARS)"
    azure_subscription="$(prop 'azure_subscription' $VNET_VARS)"
    base_state_key="$(prop 'base_state_key' $VNET_VARS)"
    statefile_suffix="$(prop 'statefile_suffix' terraform.tfvars)"

#NOTE:  {Shailender}->PLEASE FIX THIS ERROR OTHER WISE DYNAMICALLY IT WILL NOT WORK.
#         THERE IS ISSUE WITH STRING CONCAT WITH /SLAASH
    #state_file=$(printf -v c "$base_state_key/$statefile_suffix")
    #state_file="283c6862-f3c8-4296-83d4-72e662338850/southindia/vnet-dev/app/projecta/servicea/az-vm-jumphosts/terraform.tfstate"

    state_file="${azure_subscription}${base_state_key}/${statefile_suffix}"
    #echo "STATE FILE:$state_file"
    echo
    echo "${GREEN}** vNet calculated terraform backend settings: **"
    echo "--------------------------------------------------${NC}"
    ###echo "  azure_subscription  = $azure_subscription"
    echo "  environment_name    = $environment_name"
    echo "  product             = $product"
    echo "  project             = $project"
    echo "  service_name        = $service_name"
    echo "  component           = $component"
    echo "  azure_region        = $azure_region"
    echo "  azure_short_region  = $azure_short_region"
    echo "  storage_account_name = $storage_account_name"
    echo "  blob_container_name = $blob_container_name"
    echo "  base_state_key      = $base_state_key"
    echo "  statefile_suffix    = $statefile_suffix"
    #echo "  state_file          = $state_file"
    ###echo "  state_url          = $state_url"
    echo "${GREEN}--------------------------------------------------${NC}"
  fi
}
