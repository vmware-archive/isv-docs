# UAA FAQ

## UAA installations

### BOSH Director

[Creating UAA Clients for BOSH Director](https://docs.pivotal.io/pivotalcf/2-6/customizing/opsmanager-create-bosh-client.html)

[BOSH Managing Permissions with UAA Scopes](https://bosh.io/docs/director-users-uaa-scopes/#top-level-scopes)

[BOSH Director HTTP API](https://bosh.io/docs/director-api-v1/)

### CF

[User Account and Authentication (UAA) Server](https://docs.cloudfoundry.org/concepts/architecture/uaa.html)

- [Scopes](https://docs.cloudfoundry.org/concepts/architecture/uaa.html#scopes)

[Creating and Managing Users with the UAA CLI](https://docs.cloudfoundry.org/uaa/uaa-user-management.html)

## Examples

### Prerequisites

1. You have logged into the Ops Manager Web UI
2. You have a shell prompt in Ops Manager VM (via SSH)

### BOSH UAA

Make an API call to get [BOSH configs](https://bosh.io/docs/director-api-v1/#list-configs)

#### 1. Set the UAA target

```bash
uaac target 10.0.0.5:8443 --ca-cert /var/tempest/workspaces/default/root_ca_certificate
```

#### 2. Get the owner token

```bash
uaac token owner get login -s BOSH-DIRECTOR-Tile->UAA-LOGIN-CLIENT-PASSWORD
```

You will be prompted for

```bash
User Name: `admin`
Password: `BOSH-DIRECTOR-Tile->UAA-ADMIN-CLIENT-PASSWORD`
```

#### 3. Create a UAA Client

```bash
uaac client add my_client --authorized_grant_types client_credentials --authorities bosh.read --secret MY-SECRET
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
curl -k -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImprdSI6..." https://10.0.0.5:25555/configs
```

### CF UAA

[Firehose Nozzle v2 Authentication & Testing](https://github.com/cf-platform-eng/firehose-nozzle-v2/blob/master/README.md)

#### 1. Set the UAA target

```bash
uaac target uaa.sys.OPS_MAN_DOMAIN.cf-app.com
```

#### 2. Get the admin client token

```bash
uaac token client get admin -s PAS-TILE->UAA-ADMIN-CLIENT-PASSWORD
```

#### 3. Add a new client

```bash
uaac client add my-client --name my-client-name --secret MY-CLIENT-SECRET --authorized_grant_types client_credentials,refresh_token --authorities logs.admin
```

Result:

```bash
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
curl -k -H "Authorization: eyJhbGciOiJSUzI1NiIs..." 'https://log-stream.sys.OPS_MAN_DOMAIN.cf-app.com/v2/read?counter&gauge'
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
