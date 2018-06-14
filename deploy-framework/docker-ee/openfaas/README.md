# OpenFaaS - Serverless Functions Made Simple

**In this file, we detail how to deploy OpenFaaS on Docker EE. This guide only creates a development environment for OpenFaaS. Visit the OpenFaaS website for details on how to deploy for production environments.**

## Requirements

 - [Docker CLI](https://www.docker.com/get-docker)
 - A Docker EE cluster with admin credentials (see [here]() for how to install one)
 - A configured [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (follow [this guide](https://docs.docker.com/ee/ucp/user-access/kubectl/) to configure it on your cluster)

## Deploy OpenFaaS

---

You can create a separate namespace for OpenFaaS core services and functions:

```
kubectl create namespace openfaas-fn
kubectl create namespace openfaas
```

You can then do:

```
kubectl -n kube-system create sa tiller \
 && kubectl create clusterrolebinding tiller \
      --clusterrole cluster-admin \
      --serviceaccount=kube-system:tiller

helm init --skip-refresh --upgrade --service-account tiller
```

This is will initialize the Tiller component. Before continuing, wait until the output of `helm version` includes a server version in addition to the client's.

Next, setup a kube secret to enable OpenFaaS basic authentication.

```
PASSWORD=$(head -c 12 /dev/urandom | shasum| cut -d' ' -f1)
kubectl -n openfaas create secret generic basic-auth \
--from-literal=basic-auth-user=admin \
--from-literal=basic-auth-password="$PASSWORD"
echo "Credentials: username=admin, password=$PASSWORD"
```

Finally this will install openfaas. Note that the ports values are modified in order to comply with Docker EE port range restrictions:

```
helm repo update \
 && helm upgrade openfaas --install openfaas/openfaas \
    --namespace openfaas  \
    --set basic_auth=true \
    --set functionNamespace=openfaas-fn \
    --set gateway.nodePort=33000 \
    --set prometheus.nodePort=33001
```

## Removing the OpenFaaS

All control plane components can be cleaned up with helm:

```
helm delete --purge openfaas
```
