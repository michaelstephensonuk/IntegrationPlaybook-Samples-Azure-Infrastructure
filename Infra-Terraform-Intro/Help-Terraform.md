

## Running Terraform

The below instructions will help you run terraform

### Development

Open an admin command window and go to the directory for the solution.  Terraform will run against all .tf files in the directory.



```
cd .
```

Log into the Azure CLI

```
az login 
```

Set the subscription in Azure you want to use

```
az account set --subscription "[SUBSCRIPTION NAME]"
```

Initialize Terraform so you will load all of the modules needed

```
terraform init
```

You will then repeat the below steps each time you change the terraform files.  The below command will validate the code in the file is syntax correct
```
terraform validate
```

Below will refresh the state file from Azure so any changes done directly in Azure are updated into the state to manage drift
```
terraform refresh -var-file=Local.tfvars
```

Below will run a plan and tell you what changes terraform will make to your azure resources

```
terraform plan -var-file=Local.tfvars
```


Below will apply the changes to Azure
```
terraform apply -var-file=Local.tfvars
```


### Other Environments

Trigger the build/release pipeline for the environment that will do everything for you.
 

## Terraform State Management

On the local developer machine for the dev resource group we will use the default terraform.tfstate file which will manage the state for the dev resource group and it will be a resource within the devops repo.

In the other environments, CI, Test, Prod the build agent will use a remote state file held in Azure Blob storage.  This uses the remote backend capability of terraform.
The build agent will rename and configure in the pipeline the Main.Backend.tftemp file and when it is renamed to .tf extension then terraform will use it to point to its backend state in azure.

When running on the build server the build definition name is used as the state file name



# Skills Training

The following sources will help you understand the techniques used in this code base