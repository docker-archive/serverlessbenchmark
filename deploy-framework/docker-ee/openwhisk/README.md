# OpenWhisk

**In this file, we detail how to deploy [OpenWhisk](https://nuclio.io/) for the serverless benchmark on Docker EE.**

## Requirements

 - [Docker CLI](https://www.docker.com/get-docker)
 - A Docker EE cluster with admin credentials (see [here]() for how to install one)
 - A configured [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (follow [this guide](https://docs.docker.com/ee/ucp/user-access/kubectl/) to configure it on your cluster)

## Download installer

```
git clone https://github.com/jtestard/incubator-openwhisk-deploy-kube.git
cd incubator-openwhisk-deploy-kube.git
```

## Deploy Openwhisk

See the README.md file of the incubator-openwhisk-deploy-kube repo. Some notes:

 - Remember that OpenWhisk is a Kubernetes product, therefore your Docker EE cluster requires worker nodes configured with Kubernetes as their orchestrator.

## Removing Fn

See the README.md file of the incubator-openwhisk-deploy-kube repo.
