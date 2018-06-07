# Riff Platform

**In this file, we detail how to deploy [Riff](https://github.com/projectriff/riff) for the serverless benchmark on Docker EE.**

## Requirements

 - [Docker CLI](https://www.docker.com/get-docker)
 - A Docker EE cluster with admin credentials (see [here]() for how to install one)
 - A configured [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (follow [this guide](https://docs.docker.com/ee/ucp/user-access/kubectl/) to configure it on your cluster)
 - [Riff CLI](https://github.com/projectriff/riff/tree/master/riff-cli)

## Deploy Riff

Start by initializing helm:

```
helm init
```

Download the riff repo through helm:

```
helm repo add riffrepo https://riff-charts.storage.googleapis.com
helm repo update
helm search riff -l
```

Add the `riff-system` namespace:

```
kubectl create namespace riff-system
```

Grant the following Docker EE permissions by using this [guide](https://docs.docker.com/ee/ucp/authorization/grant-permissions/):

| Namespace   	| Service Account 	| Role               	| Resource Set         	|
|-------------	|-----------------	|--------------------	|----------------------	|
| default     	| default         	| Restricted Control 	| kubernetesnamespaces 	|
| riff-system  	| default         	| Restricted Control 	| kubernetesnamespaces 	|
| kube-system 	| default         	| Full Control      	| kubernetesnamespaces 	|

To select the `kubernetesnamespaces` resource set, on the Create Grant page under the Resource Sets tab, select the **namespaces** type and toggle
"Apply Grant to all existing and new namespaces".

```
helm install --name transport --namespace riff-system riffrepo/kafka
helm install riffrepo/riff --version 0.0.5 --name demo --set rbac.create=false --set httpGateway.service.type=NodePort
```

Now that the repo is installed, apply the following grant

| Namespace   	| Service Account 	| Role               	| Resource Set         	|
|-------------	|-----------------	|--------------------	|----------------------	|
| default     	| demo-riff       	| Restricted Control 	| kubernetesnamespaces 	|

## Install Riff Invokers

Riff invokers are required to deploy functions with Riff. They can be installed after the CLI is.

```
riff invokers apply -f https://github.com/projectriff/command-function-invoker/raw/v0.0.6/command-invoker.yaml
riff invokers apply -f https://github.com/projectriff/go-function-invoker/raw/v0.0.3/go-invoker.yaml
riff invokers apply -f https://github.com/projectriff/java-function-invoker/raw/v0.0.7/java-invoker.yaml
riff invokers apply -f https://github.com/projectriff/node-function-invoker/raw/v0.0.8/node-invoker.yaml
riff invokers apply -f https://github.com/projectriff/python3-function-invoker/raw/v0.0.6/python3-invoker.yaml
```

## Notes

 - Remember that gestalt is a Kubernetes-only product, therefore your Docker EE cluster requires worker nodes configured with Kubernetes as their orchestrator.
 - Update instructions to use an ingress and a service of type LoadBalancer.
