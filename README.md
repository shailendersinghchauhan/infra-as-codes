# Azure Terraform Configurations
Repository for providing management of Azure infrastructure and setting up application delivery components.

Terraform is responsiable for setting up Azure infrastrucutre to deploy package applications into reliabiliy.  

## Version History
* v1.0.0 - Initial version of infra-as-codes

## Accounts
Specific account(teams) deployments into Azure using some custom but mostly shared resources in the azure folder.  

The idea is that the shared resources are bare minimum requirements for security and seperation of services for exposure.  

CI tools use these Configurations to update and manage the infrastrucutre which can mean they will overright any manual changes not committed for certain environments.

### How to Use

* Setup your credentials to use for the appropriate Azure account.
* To check for updates for a particular managed infrastructure use the following:

The vnet Directory of each account provides the defaults and is used for intialization, since all stacks require the vnet.

Basic Intialization Pattern when in a terraform accounts config, after adding [TERRAFORM_HOME]/scripts to your PATH.
```
# RunTerraform.sh
```

Navigate to the working directory:
```
# cd teams/sre/southindia/dev/vnet/
```

Download the latest state file from Azure Storage (Blob) into the working directory, updates modules and runs a plan.
```
# RunTerraform.sh
```

To Execute the Plan shown above.
```
# terraform apply
```

## Manual Commands
NOTE:
Only required in case you are testing something manually otherwise RunTerraform.sh is supposed to perform below steps.
Run the terraform get, to grab modules.
```
# terraform get -update
```

Run the plan command to see what changes maybe waiting.
```
# terraform plan
```

If changes are waiting and they are okay to apply to the environment, run the apply.
```
# terraform apply
```

## Submitting Pull Requests
First step, fork the repository to your local account.  

### Clone it locally
```
# git clone https://github.com/shailendersinghchauhan/infra-as-codes.git
```

### Link it to the remote one for updates
```
# cd infra-as-codes 
# git remote add upstream 
```

### Sync it and push back to your repo
```
# git fetch upstream develop
... Bunch of stuff
# git merge upstream/develop
# git push origin develop
```
**Repository Managed by:**
```
Shailender Singh
```
We welcome pull request from any team who would like to contribute to our code base.

**Created On:** 30/05/2022

**Last Updated on:** 30/05/2022

**NOTE**:
 Works with latest 1.2.2 version
Please don't merge directly to master branch and push your changes to develop either directly or using fork option.
