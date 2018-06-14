# OpenFaaS - Serverless Functions Made Simple

**In this file, we detail how to deploy OpenFaaS for the serverless benchmark on Docker EE.**

## Requirements

 - A Docker EE cluster with admin credentials (see [here]() for how to install one)
 - A configured [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (follow [this guide](https://docs.docker.com/ee/ucp/user-access/kubectl/) to configure it on your cluster)
 - The [faas-cli](https://github.com/openfaas/faas-cli)

### Golang (HTTP) Example

The Golang HTTP template is a runtime for openfaas geared towards speeding up function invocation latency.

```
mkdir hello-world-http && cd hello-world-http
faas-cli template pull https://github.com/openfaas-incubator/golang-http-template
faas-cli new --lang golang-http hello-world-http
```

Now edit the `hello-world-http.yml` file as follows:

```
provider:
  name: faas
  gateway: http://$DOCKER_EE_IP:33000

functions:
  hello-world:
    lang: golang-http
    handler: ./hello-world-http
    image: $DOCKER_HUB_USERNAME/hello-world-http
```

where `$DOCKER_EE_IP` is your docker ee ip and `$DOCKER_HUB_USERNAME` is your Docker Hub username.

Finally, here is how to build, ship and deploy the function:

```
faas-cli build -f hello-world-http.yml
faas-cli push -f hello-world-http.yml
faas-cli deploy -f hello-world-http.yml
```

Finally, invoke your function:

```
curl http://34.221.85.65:33000/function/hello-world-http -X POST -H "Content-Type: application/json" -d '{"name": "jules"}'
```
