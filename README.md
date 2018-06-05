# Deploying and Benchmarking Open Source Serverless Frameworks

Since the advent of AWS Lambda in 2014, the function-as-a-service programming paradigm has gained a lot of traction in the cloud community. At first, only large cloud providers such as AWS, GKE or Azure provided such services with a pay-per-invocation model, but since then interest has increased for developers and entreprises to build their own solutions on an open source model.

The rise of container orchestrators such as Kubernetes, Docker Swarm or DC/OS has made this process even easier, resulting in a number of competing frameworks in this space. These frameworks vary a lot in feature set, but all have the feature we come know to expect from a FaaS offering in the style of AWS Lambda:

 - The ability to create and modify language-specific scripts with a simple interface in either "inline" (within browser) or packaged form.
 - The ability to invoke functions through an HTTP API.

Finally, all of these frameworks can easily be deploying using a Kubernetes distribution.

In this project, we provide common ways to both deploy and benchmark these open source serverless frameworks.

### Project Organization

 - In the deploy-cluster folder, we provide, for each vendor, how to deploy a cluster fitted for benchmarking for each kubernetes vendor
 - In the deploy-framework folder, we provide, for each serverless framework, how to deploy it on each vendor.
 - In the deploy-function folder*, we provide, for each serverless framework, how to deploy functions used for benchmarking.

\*: currently missing.

### Open Source Serverless Frameworks

 - OpenFaaS
 - Nuclio
 - Gestalt
 - Riff
 - Fn

### Kubernetes Vendors

For now, the only vendor that is suppported is Docker Entreprise Edition.

### Notes

 - The benchmarking component of this repository has not been released yet.
