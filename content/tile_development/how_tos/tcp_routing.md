# TCP Routing

## Overview

By default external [TCP Routing](https://docs.pivotal.io/pivotalcf/opsguide/tcp-routing-ert-config.html) is not enabled in PAS. 

For details see [Configuring Routes and Domains](https://docs.pivotal.io/pivotalcf/devguide/deploy-apps/routes-domains.html)

## Internal TCP Routing

Internal TCP routing uses `apps.internal`, which is not protocol-specific. 

For more information see:

- [Polyglot Service Discovery](https://www.cloudfoundry.org/blog/polyglot-service-discovery-container-networking-cloud-foundry/)
- [Cats and Dogs without Service Discovery](https://github.com/cloudfoundry/cf-networking-examples/blob/master/docs/c2c-no-service-discovery.md)

### Create an Internal Route

#### 1. [Map a route](https://docs.cloudfoundry.org/devguide/deploy-apps/routes-domains.html#map-route)

```bash
cf map-route MY-SERVICE-APP apps.internal --hostname MY-SERVICE
```

#### 2. [Add a Network Policy](https://docs.cloudfoundry.org/devguide/deploy-apps/cf-networking.html#add-policy)

```bash
cf add-network-policy SOURCE-APP \
    --destination-app MY-SERVICE-APP \
    --protocol tcp \
    --port MY-PORT-OR-RANGE
```

## External TCP Routing

### Enabling

1. Login to **Ops Manager**
2. Click the **PAS** tile
3. In the **Settings** tab click **Networking**
   1. Scroll down and choose the **Enable TCP Routing** option
   2. For **TCP Routing Ports** enter `1024-1123`
      - This is the default range configured in GCP
   3. Click **Save**.
4. While still in **Settings**, scroll down and click **Resource Config**.
   1. In the **TCP Router** row for the **Load Balancer** enter the name `tcp:MY_ENVIRONMENT_NAME-cf-tcp`.
      - Follow the same pattern the **Router** and **Control** rows have but end in `-tcp` instead. This is the PIE default naming convention.
   2. Click Save
5. **APPLY CHANGES**

For additioanl information see:
- [Configuring TCP Routing in PAS](https://docs.pivotal.io/pivotalcf/opsguide/tcp-routing-ert-config.html)

### Create an External Route

#### 1. Configure a TCP Domain and Quota by following the [Post-Deployment Steps](https://docs.pivotal.io/pivotalcf/adminguide/enabling-tcp-routing.html#post-deploy)

```bash
cf create-shared-domain MY-SHARED-TCP-DOMAIN \
    --router-group default-tcp
```

```bash
cf update-quota default \
    --reserved-route-ports NUM-PORTS
```

#### 2. [Create the Route](https://docs.pivotal.io/pivotalcf/devguide/deploy-apps/routes-domains.html#create-route-with-port)

```bash
cf create-route MY-SPACE MY-SHARED-TCP-DOMAIN \
    --random-port
```

#### 3. Get the port number

```bash
cf routes
```

#### 4. [Map a route](https://docs.cloudfoundry.org/devguide/deploy-apps/routes-domains.html#map-route)

```bash
cf map-route MY-APP MY-SHARED-TCP-DOMAIN \
    --port RANDOM-PORT
```
