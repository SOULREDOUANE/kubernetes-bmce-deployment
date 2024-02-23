# Exploring Kubernetes Architecture and Application Deployment

Welcome to our repository! Here, we embark on an exciting journey to delve into the architecture of Kubernetes and unravel the deployment process of an application meticulously crafted for BMCE Bank.

## Application Overview

Our application boasts two frontend services:

- **Admin App**: An intuitive admin interface.
- **Client Access Portal**: A seamless portal for client access.

These frontend marvels seamlessly communicate with a robust **Spring backend application**. Moreover, our backend orchestrates data exchange with an **FTP server application**, ensuring smooth operation.

## Repository Contents

Due to confidentiality reasons, we are unable to share the source code in this repository. However, we provide the following:

- **Jenkinsfiles**: Located in [location].
- **Dockerfiles**: Located in [location].

These files offer insight into our CI/CD pipeline. Please note that our Jenkinsfiles may lack a crucial stage: triggering Kubernetes to update the deployment.

## Deployment Guide

In this README, we invite you on a journey to explore how we deployed this application using an EC2-based cluster. We've meticulously included all Terraform files and scripts required to set up your cluster. (Inspired by the KodeKloud repository, we aim to provide comprehensive setups.)

## Getting Started
# BMCE Bank Application Deployment Guide

Welcome to the deployment guide for the BMCE Bank application! This guide will walk you through the setup and configuration of our Kubernetes cluster, including provisioning nodes, setting up namespaces, and deploying PostgreSQL using a StatefulSet.

## Cluster Overview

We've provisioned a Kubernetes cluster consisting of:

- **Control Plane**: Acts as the master node.
- **Node01** and **Node02**: Nodes for workload deployment.
- **Student-node**: A node with the `kubectl` Kubernetes client installed for cluster access.

We'll be working in the `bmce-app` namespace instead of the default one.

## Setup PostgreSQL Database

To set up the PostgreSQL database, follow these steps:

1. Create a namespace for the BMCE Bank application:
   ```bash
   kubectl create namespace bmce-app

2. Set the current namespace to bmce-app:
    ```bash 
    kubectl config set-context --current --namespace=bmce-app

3. Create a persistent volume named "data" to be mounted to the PostgreSQL pod later when created:

    ```bash 
    kubectl create -f k8s/volume/pv-volume.yml

4. Create a secret file containing environment variables for the PostgreSQL pod:
    ```bash
    kubectl create secret generic postgresql \
    --from-literal=POSTGRES_USER="ops4team" \
    --from-literal=POSTGRES_PASSWORD='devops4team' \
    --from-literal=POSTGRES_DB="mydatabase" \
    --from-literal=REPLICATION_USER="replicationuser" \
    --from-literal=REPLICATION_PASSWORD='replicationPassword'

5. Create a ConfigMap that contains PostgreSQL configuration and then create the StatefulSet + clusterip service :

    ```bash 
    kubectl apply -f k8s/database/postgres-statefulset.yml

## Spring backend application
In the file k8s/main-backend-api/deployment.yml, the deployment and service configurations for the Spring backend application are defined. Additionally, environment variables are configured to use the secret file we've just created.

1. Create the resources defined in the deployment.yml file: 
    ```bash 
    kubectl create -f  k8s/main-backend-api/deployment.yml


2. Check that the pods are running successfully and service endpoints:
    ```bash 
    kubectl get pods -o wide  -l app=backend
    kubectl describe svc | grep -i endpoints // make sure endpoints match the ip of pod
## FTP Server Application Configuration
For the FTP server application, we'll apply a similar configuration as we did for the Spring backend app. Additionally, we've included a config map in its YAML file containing all the necessary environment variables for the FTP service to communicate with the backend app.

To deploy the FTP server application, follow these steps:

1. Apply the configuration defined in the YAML file for the FTP server:
    ```bash 
    kubectl apply -f  k8s/ftp-server/deployment.yml


## Main App

Regarding the main frontend app, we've defined a config map containing the name of the backend service, which will be injected as an environment variable for the pod. Additionally, we've defined the deployment and service specifications. The service type used is NodePort on port 30009.

1. Apply the configuration defined in the YAML file for the main frontend app:
    ```bash 
    kubectl apply -f k8s/react-admin-app/deployment.yml

2. Verify that the app is successfully connected to the backend app.


## Admin App

We'll apply the same configuration for the Admin app, except that we'll use the same config map defined in the previous YAML file. This time, the service is exposing port 30008.

1. Apply the configuration defined in the YAML file for the Admin app:
    ```bash 
    kubectl apply -f k8s/react-admin-app.deployment.yml
