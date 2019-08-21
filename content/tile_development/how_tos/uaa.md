# UAA

## Overview

[User Account & Authentication (UAA)](https://docs.pivotal.io/pivotalcf/uaa/uaa-overview.html) provides standards driven identity-based security for applications and APIs. It may be interacted with via the [UAA API](https://docs.cloudfoundry.org/api/uaa/) or [UAA CLI (UAAC)](https://github.com/cloudfoundry/cf-uaac/blob/master/README.md). See [Managing Clients with UAAC](https://docs.pivotal.io/p-identity/manage-clients-api.html) for guidelines on when to use or not use it.

[UAA](https://github.com/cloudfoundry/uaa/blob/develop/README.md) is open source and the [Server](https://docs.pivotal.io/pivotalcf/concepts/architecture/uaa.html) may be used for your own projects.

## UAA Installations

There are two standard UAA intallations in a [Partner Integration Environment](../../pie_environments.md).

### CF

[Scopes](https://docs.pivotal.io/pivotalcf/concepts/architecture/uaa.html#scopes)

[Creating and Managing Users with the UAA CLI](https://docs.cloudfoundry.org/uaa/uaa-user-management.html)

### BOSH Director

[Scopes](https://bosh.io/docs/director-users-uaa-scopes/#top-level-scopes)

[Creating UAA Clients for BOSH Director](https://docs.pivotal.io/pivotalcf/customizing/opsmanager-create-bosh-client.html)

[Director HTTP API](https://bosh.io/docs/director-api-v1/)

## Examples

### Prerequisites

1. You are logged into the Ops Manager web application
2. You are logged into [Ops Manager with SSH](https://docs.pivotal.io/pivotalcf/customizing/trouble-advanced.html#ssh)

### BOSH UAA

Make an API call to get [BOSH configs](https://bosh.io/docs/director-api-v1/#list-configs)

#### 1. Set the UAA target

```bash
uaac target 10.0.0.5:8443 \
  --ca-cert /var/tempest/workspaces/default/root_ca_certificate
```

#### 2. Get the owner token

```bash
uaac token owner get login \
  -s BOSH-DIRECTOR-Tile->UAA-LOGIN-CLIENT-PASSWORD
```

You will be prompted for

```bash
User Name: `admin`
Password: `BOSH-DIRECTOR-Tile->UAA-ADMIN-CLIENT-PASSWORD`
```

#### 3. Create a UAA Client

```bash
uaac client add my_client \
  --authorized_grant_types client_credentials \
  --authorities bosh.read \
  --secret MY-SECRET
```

#### 4. Get the new clients token

```bash
uaac token client get my_client -s MY-SECRET
```

#### 5. Get the context

```bash
uaac context
```

Results:

```
[0]*[https://10.0.0.5:8443]
  skip_ssl_validation: true
  ca_cert: /var/tempest/workspaces/default/root_ca_certificate

[1]*[my_client]
    client_id: my_client
    access_token: eyJhbGciOiJSUzI1NiIsImprdSI6...
    token_type: bearer
    expires_in: 43199
    scope: bosh.read
    jti: 9c26b5b280034...
```

#### 6. Director API call

```bash
curl -k -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImprdSI6..." \
  https://10.0.0.5:25555/configs
```

### CF UAA

Example from [Firehose Nozzle v2 Authentication & Testing](https://github.com/cf-platform-eng/firehose-nozzle-v2/blob/master/README.md)

#### 1. Set the UAA target

```bash
uaac target uaa.sys.OPS_MAN_DOMAIN.cf-app.com
```

#### 2. Get the admin client token

```bash
uaac token client get admin \
-s PAS-TILE->UAA-ADMIN-CLIENT-PASSWORD
```

#### 3. Add a new client

```bash
uaac client add my-client \
  --name my-client-name \
  --secret MY-CLIENT-SECRET \
  --authorized_grant_types client_credentials,refresh_token \
  --authorities logs.admin
```

Result:

```
  scope: uaa.none
  client_id: my-client
  resource_ids: none
  authorized_grant_types: refresh_token client_credentials
  autoapprove:
  authorities: logs.admin
  name: my-client-name
  required_user_groups:
  lastmodified: 1566366324000
  id: my-client
```

#### 4. Get the new clients token

```bash
uaac token client get my-client -s MY-CLIENT-SECRET
```

Result:
```bash
Successfully fetched token via client credentials grant.
Target: https://uaa.sys.OPS_MAN_DOMAIN.cf-app.com
Context: my-client, from client my-client
```

#### 5. Get the context

```bash
uaac context
```

Results:

```
[2]*[https://uaa.sys.OPS_MAN_DOMAIN.cf-app.com]
  skip_ssl_validation: true

[2]*[my-client]
    client_id: my-client
    access_token: eyJhbGciOiJSUzI1NiIs...
    token_type: bearer
    expires_in: 43199
    scope: logs.admin
    jti: c2b23ef2757a4b6...
```

#### 6. Make an API call for Nozzle data

```bash
curl -k -H "Authorization: eyJhbGciOiJSUzI1NiIs..." \
  'https://log-stream.sys.OPS_MAN_DOMAIN.cf-app.com/v2/read?counter&gauge'
```

Result:

```json
data: {
    "batch":[{
        "timestamp":"1566366890684405285",
        "source_id":"metron",
        ...
    }]
}
```

## Troubleshooting

### Bad Credentials

Indicates either the wrong UAA instance is targeted, or you are using incorrect credentials. See [UAA Installations](#uaa-installations)

```bash
$ uaac token client get admin
Client secret:  ********************************
```

```
error response:
{
  "error": "unauthorized",
  "error_description": "Bad credentials"
}
attempt to get token failed
```