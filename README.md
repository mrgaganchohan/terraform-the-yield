# Yield App

## **Viewing This file**:
This readme file can be best read on github page. https://github.com/mrgaganchohan/terraform-the-yield (develop branch)

## Demo of App:
https://app-service-yield-frontend.azurewebsites.net/
## Functionality of the app

Yield App is a very basic app which has a frontend which sends and consumes the Azure Service bus queue messages. 
All App services has CI/CD done, and is part of their respective codebase (links at the bottom of this document)
* Website can be accessed at https://app-service-yield-frontend.azurewebsites.net/ . Screenshot of the frontend can be found in source code under 'Infra Architecture' named as 'Screenshot.png'
* Diagram of infrastructure: Diagram of infra can be found under folder 'Infra Architecture'. It can also be found at this link: https://excalidraw.com/#json=pfpjBA5lJM1MLlT7UecNp,mAdqur8Ba-9FNW6xsakweg

## Infrastructure of the app:
Infrastructure has been structured for a microservice architecture. Following Resources were created in Azure using terraform:
* **Resource Group**: All resources are created under resource group called 'rg-yield-app'
* **Service Bus**: Service bus is used for messages in the Queue.
* **App Plan**: There is an app plan, named 'plan-yield-app' used for hosting App Services. This app group holds frontend app and two backend apps.  The following **App Services** are there:
    - **Nodejs Message Creator App Service**: This app creates a Message in a queue under Azure Service Bus. This message is later consumed by  nodejs Consumer App.
    - **Nodejs Message Consumer App Service**: This app is used to consume messages from queue, one message at a time. It could have been created as a function App as well.
    - **Frontend App Service**: This is a react app which is used to call apis in creator and consumer nodejs services to create and consume queue messages.

So the basic architecture of app is that the frontend app calls backend nodejs Message Creator app to create a queue Message and calls  node consumer app to consume messages. 

Creation and consumption has been done in different apps to demonstrate microservices architecture. Depending on the situation instead of frontend app calling both frontend and backend app, one microservice can also directly contact other microservice through service bus in a real life project with microservices.


## Structure of Terrform Project:

The project has following structure:
Terraform project doesn't have azure credentials, user needs to follow steps as mentioned under 'How to run this project' to setup azure CLi with proper creds. Structure of terraform project is as follows:
  * main.tf (root directory): It basically specifies that azure has to be used, and it calls the different files in modules that has infrastructure creation files in it. 
  * **modules folder**: There is a modules folder which has different folders under it for better organisation of different files of terraform. All the sub-folders has a main.tf file which contains resource definitions. Module foolder has following:
    - **common_resources**: Common resources are used to create resources which are common for both frontend and backend. It includes resources like: resource groups and app Service plan.
    - **frontend**: Frontend contains Linux App Service resource
    - **backend**: Backend contains two linux App Services for node Apps and a service bus
  * **Infra Architecture**: This folder contains screenshot for frontend and architecture.

## How to run this project

### Install Azure CLI tool on local machine:
Please follow instructions as mentioned here: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

### Set up Azure credentials in Azure CLI:
To set up Azure credentials, after installing azure cli, run following command. It will set up credentials with azure.
```
az login
```
## Running the project.
Make sure you are in root directory, and run following commands
```
terraform init
terraform plan
terraform apply (enter yes on getting a prompt)
```

## CodeBase:
Codebase for different apps used which are deployed on three different app services are:
* **react frontend**: https://github.com/mrgaganchohan/yield-react-app 
* **nodejs Message Creator App**: https://github.com/mrgaganchohan/yield-queue-sender-producer
* **nodejs Message Consumer App**: https://github.com/mrgaganchohan/yield-node-consumer

## CI/CD pipelines:
All the code for above mentioned code has been deployed through Azure pipelines, and **'azure-pipelines.yml'** can be found in the master branch of all the above mentioned codebases.
Because of the time constraint, It has hard coded values of subscriptionID and app-Service name in the commits, but ideally it would have not been included in the source code. But nothing can be deployed to them by a third party in my azure portal, as Azure Pipelines will ask for credentials. 

In CI/CD if you use azure-files, you might have to update your suscription id in azure-pipelines.yml, and in nodejs apps replace service bus launch URL