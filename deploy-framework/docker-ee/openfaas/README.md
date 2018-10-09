# OpenFaaS - Serverless Functions Made Simple

**In this file, we detail how to deploy OpenFaaS for the serverless benchmark on Docker EE.**

## Requirements

 - [Docker CLI](https://www.docker.com/get-docker)
 - A Docker EE cluster with admin credentials (see [here]() for how to install one)
 - A configured [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (follow [this guide](https://docs.docker.com/ee/ucp/user-access/kubectl/) to configure it on your cluster)

## Deploy OpenFaaS

---

You can create a separate namespace for OpenFaaS core services and functions:

```
kubectl apply -f https://raw.githubusercontent.com/openfaas/faas-netes/master/namespaces.yml
```

Grant the following Docker EE permissions by using this [guide](https://docs.docker.com/ee/ucp/authorization/grant-permissions/):

| Namespace   	| Service Account 	| Role               	| Resource Set         	|
|-------------	|-----------------	|--------------------	|----------------------	|
| openfaas    	| default         	| Full Control 	| kubernetesnamespaces 	|
| openfaas-fn 	| default         	| Full Control 	| kubernetesnamespaces 	|
| kube-system 	| default         	| Full Control 	| kubernetesnamespaces 	|

To select the `kubernetesnamespaces` resource set, on the Create Grant page under the Resource Sets tab, select the **namespaces** type and toggle
"Apply Grant to all existing and new namespaces".

```
helm init
```

This is will initialize the Tiller component. Before continuing, wait until the output of `helm version` includes a server version in addition to the client's.

```
git clone https://github.com/openfaas/faas-netes.git
cd faas-netes/chart/openfaas
```

The default NodePorts used by OpenFaaS are in a range not valid for Docker EE. The commands below will change those port values.

```
sed -i '' s/"nodePort: 31112"/"nodePort: 33000"/g ./values.yaml
```

Finally this will install openfaas:

```
helm install . --name openfaas \
   --namespace openfaas \
   --set rbac=false \
   --set functionNamespace=openfaas-fn
```

With these instructions, NodePort services will be created for the API Gateway.

Finally, an extra grant is required to actually deploy functions:

| Namespace   	| Service Account 	| Role               	| Resource Set         	|
|-------------	|-----------------	|--------------------	|----------------------	|
| openfaas    	| faas-controller  	| Full Control 	      | openfaas-fn         	|


## Removing the OpenFaaS

All control plane components can be cleaned up with helm:

```
helm delete --purge openfaas
```

## TODO

 - Once Docker Certified Infrastructure 2.0.0 becomes available, change these instructions to use an ingress load balancer instead.
