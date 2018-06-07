# Fn Platform

**In this file, we detail how to deploy [Fn](https://github.com/fnproject/fn) for the serverless benchmark on Docker EE.**

## Requirements

 - [Docker CLI](https://www.docker.com/get-docker)
 - A Docker EE cluster with admin credentials (see [here]() for how to install one)
 - A configured [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (follow [this guide](https://docs.docker.com/ee/ucp/user-access/kubectl/) to configure it on your cluster)

## Download installer

```
git clone https://github.com/jtestard/fn-helm.git
cd fn-helm
```

## Deploy Fn

See the README.md file of the fn-helm repo. Some notes:

 - Remember that fn is a Kubernetes-only product, therefore your Docker EE cluster requires worker nodes configured with Kubernetes as their orchestrator.

## Removing Fn

See the README.md file of the fn-helm repo.
