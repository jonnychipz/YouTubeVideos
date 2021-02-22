#Build Image
docker-compose up --build

#login to Azure
az login

#set subscription
az account set --subscription "MPN - John Lunn"

#Create Resource Group
az group create --name jonnychipz-acr-rg --location uksouth

#Create Azure Container Registry
az acr create --resource-group jonnychipz-acr-rg --name jonnychipzacr001 --sku Basic

#Logon to ACR
az acr login --name jonnychipzacr001 

#Push Image to ACR
docker tag jonnychipz-blazorwasm jonnychipzacr001.azurecr.io/jonnychipz-blazorwasm:v1
docker push jonnychipzacr001.azurecr.io/jonnychipz-blazorwasm:v1

#List Images in ACR
az acr repository list --name jonnychipzacr001.azurecr.io --output table

#Run image from ACR
 docker run -p 8080:80 jonnychipzacr001.azurecr.io/jonnychipz-blazorwasm:v1
 