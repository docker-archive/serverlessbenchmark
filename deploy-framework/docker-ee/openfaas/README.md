# OpenFaaS - Serverless Functions Made Simple

**In this file, we detail how to deploy OpenFaaS for the serverless benchmark on Docker EE.**

These instructions are heavily influenced by those used in the [faas-netes](https://github.com/openfaas/faas-netes/tree/master/chart/openfaas) project.

## Requirements

 - [Docker CLI](https://www.docker.com/get-docker)
 - A Docker EE cluster with admin credentials (see [here]() for how to install one)
 - A configured [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (follow [this guide](https://docs.docker.com/ee/ucp/user-access/kubectl/) to configure it on your cluster)

## Deploy OpenFaaS

---

You can create a separate namespace for OpenFaaS core services and functions:

```
kubectl create ns openfaas
kubectl create ns openfaas-fn
```

Grant the following Docker EE permissions by using this [guide](https://docs.docker.com/ee/ucp/authorization/grant-permissions/):

| Namespace   	| Service Account 	| Role               	| Resource Set         	|
|-------------	|-----------------	|--------------------	|----------------------	|
| openfaas    	| default         	| Restricted Control 	| kubernetesnamespaces 	|
| openfaas-fn 	| default         	| Restricted Control 	| kubernetesnamespaces 	|
| kube-system 	| default         	| Restricted Control 	| kubernetesnamespaces 	|

To select the `kubernetesnamespaces` resource set, on the Create Grant page under the Resource Sets tab, select the **namespaces** type and toggle
"Apply Grant to all existing and new namespaces".

This is will initialize the Tiller component. Before continuing, wait until the output of `helm version` includes a server version in addition to the client's.

```
helm init
```

This command should be run from within the `frameworks/openfaas/deploy_framework` folder or equivalent:

```
helm upgrade --install openfaas . \
   --namespace openfaas \
   --set rbac.create=false \
   --set functionNamespace=openfaas-fn
```

With these instructions, NodePort services will be created for the API Gateway and Prometheus.

## Removing the OpenFaaS

All control plane components can be cleaned up with helm:

```
$ helm delete --purge openfaas
```

## TODO

 - Once Docker Certified Infrastructure 2.0.0 becomes available, change these instructions to use an ingress load balancer instead.
