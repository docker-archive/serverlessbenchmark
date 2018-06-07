# Gestalt Platform

**In this file, we detail how to deploy Gestalt for the serverless benchmark on Docker EE.**

## Requirements

 - [Docker CLI](https://www.docker.com/get-docker)
 - A Docker EE cluster with admin credentials (see [here]() for how to install one)
 - A configured [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (follow [this guide](https://docs.docker.com/ee/ucp/user-access/kubectl/) to configure it on your cluster)

## Download installer

```
git clone https://github.com/jtestard/gestalt-k8s-install.git
cd gestalt-k8s-install
git checkout docker-ee-changes
```

## Deploy Gestalt

See the README.md file of the installer repo. Some notes:

 - Remember that gestalt is a Kubernetes-only product, therefore your Docker EE cluster requires worker nodes configured with Kubernetes as their orchestrator.

## Removing Gestalt

See the README.md file of the installer repo.
