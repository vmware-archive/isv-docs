# PCF 2.4 / PKS 1.3

Hello Pivotal Partners,

PCF 2.4 is scheduled for release in early December. With this release, we have a handful of changes that require attention from tile authors.

## PCF 2.4 Breaking Changes

### Credhub 2.0

Credhub 2.0 has backwards-incompatible API and manifest changes. The biggest changes are:

*   **Authorization model changes:** Identities will no longer be able to write to CredHub solely by virtue of authenticating. Instead, an explicit access control entry will need to be created, granting an identity read, write, delete, read_acl, and/or write_acl permissions to an identity, for a given namespace.
*   **`set` and `generate` changes:** CredHub is simplifying the rules that determine when `set` or `generate` requests will do nothing or overwrite existing values.
*   **Minor manifest changes: **The structure of our properties hash is changing slightly.
*   **Authorization on by default: **The default value of `credhub.authorization.acls.enabled` is changing from false to true.

For tiles that are already consuming CredHub 1.9.x, there will not be any breaking changes. If you use CredHub, please perform regression testing with PAS for Credhub 2.0. We can give you access to an environment with an alpha PAS release with the new credhub verison.

Customers who do a fresh install of PAS will be impacted, and will need to apply new permissions when bootstrapping. The Credhub 2.0 upgrade does not affect customers who upgrade PAS.

### Migrate cflinuxfs2 apps over to cflinuxfs3

In PAS 2.4, cflinuxfs3 will be the default stack underneath `cf push`ed applications. If your tile contains errands that push applications (e.g. Tile Generator `app` or `app-broker` packages, other service brokers), you must update to explicitly push apps with cflinuxfs3.

Tile Generator updates to enable cflinuxfs3 will come in November. The stack property on apps is sticky, so it will not change automatically unless they are explicitly re-pushed with cflinuxfs3.

Canonical will end general support for cflinuxfs2 stack (derived from Ubuntu Trusty 14.04 LTS) on April 18th, 2019. Because of this, we plan to remove cflinuxfs2 in a patch release of PCF 2.4.

### PCF 2.4 will not support cf-mysql or MySQLv1

PCF 2.4 will not support older versions of MySQL (cf-mysql and MySQL for PCF v1). For existing v1 users, v1 will be supported through October 2018.

### Xenial Stemcells

Canonical will end support for Ubuntu Trusty Tahr on April 30th, 2019 and security fixes will no longer be backported.  PCF is transitioning to use stemcells based on Xenial Xerus and will no longer support Trusty stemcells in PCF 2.5.  Tile authors should start testing with the Xenial stemcells and fix any compatibility issues.  For more information, please see the communication from us on July 19th.

Xenial stemcells are now available on [Pivotal Network](https://network.pivotal.io/).

### Consul Removal / BOSH DNS Adoption

For tiles that include consul clients: by the time a customer upgrades to PCF 2.4, you **must have removed consul clients** from your product, because the server will be completely gone and your deployments will fail to deploy.

If your product needs to _support multiple versions of PCF_: you need to conditionally turn consul on/off in the 2.2 version of your product, as the manifest snippet below shows.  Then you need to remove consul clients in the 2.3 version of your product, once you can count on BOSH DNS.

```
  - name: consul_agent
    release: consul
    consumes: |
      consul_common: {from: consul_common_link, deployment: "(( ..cf.deployment_name ))"}
      consul_client: {from: consul_client_link, deployment: "(( ..cf.deployment_name ))"}
      consul_server: nil
    manifest: |
      ---
      consul:
        client:
          enabled: "(( $ops_manager.dns_enabled ? false : true ))"
```

## Upcoming Deprecations

### Use UAA Client Credentials Instead of Admin Users

The introduction of `cf auth --client-credentials` allows components using `cloud_controller.admin` to leverage a client instead of a user. PCF 2.5 will include a set of `tile_installer_client` credentials to bootstrap client credentials for long-term use, instead of using shared admin-level credentials.

The benefits of this include supporting customers who need to use two-factor authentication for users, disabling internal users to meet compliance regulations, and better support for credential rotation.

As the details of this develop, we plan to enhance Tile Generator to help make this process smoother. In the meantime, if you would like more information, please reach out to us in Pivotal Partners Slack.

### PAS Components Moving to BPM

Internal PAS components plan to use the BOSH Process Manager (BPM) in PCF 2.5 to keep jobs simpler, boilerplate-free, and isolated from one another so processes cannot leak data to each other. This should be transparent for most partner products, but will change the structure of internal PAS component deployments. Partners may also look to use BPM in their own BOSH releases.

## PKS 1.3 New Features

We are targeting PKS 1.3 for a  early January release.  Date TBD pending when ⅔ major IaaSs release their K8s 1.12 compatible version.  [Please see the Aha! For the latest with PKS ](https://pcf.aha.io/products/KUBO/feature_cards)

### Kubernetes 1.12

PKS 1.3 will support K8s 1.12.  Known changes in K8s 1.12 can be found here: [https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md)

### Configurable network options for clusters

Allows customers to to enable different network configuration for different clusters. With this capability, they can select the appropriate T) the cluster should route Ingress & Egress from. This will help allow increased scale (both at PKS level and at a per cluster level) and network security isolation when multiple tenants use PKS.  

### Azure Support (Beta)

PKS 1.3 intends to add Azure support as a beta feature.  Note this will not be compatible with NSX-T.   This will allow PKS workloads to be deployed on Azure.  The Beta designation is because there is a capability we are waiting on Microsoft to enable multiple MSIs, as without this feature there are security concerns deploying Azure on production workloads (non-production should be fine).  

## PCF 2.3 Compatibility Reminder

### BOSH DNS Adoption (Consul Server Removed)

In PCF 2.3, Consul server will be removed and [BOSH DNS](https://bosh.io/docs/dns/) will be used instead.  Tile authors should start the process of removing Consul **agents**, which needs to be completed by PCF 2.4. Consul will be completely removed by PCF 2.5.

### Credhub

Credhub 2.0 will be available for PCF 2.3 and may affect partner tiles in three areas:

1. Ops Manager will act as the CredHub client, and the tile can continue to use the  \
``((( VARIABLE )))`` syntax for templating.  This should not affect most tile authors.
2. If your tile includes a service broker that uses the [secure credentials workflow](https://github.com/cloudfoundry-incubator/credhub/blob/master/docs/secure-service-credentials.md#updated-service-workflow), that service broker would act as a CredHub client and will need updating. Likewise, if a tile includes an app that uses this workflow, that app would act as a CredHub client and will need updating.
3. If your tile includes its own CredHub instance, this not affected by this upgrade.  Your tile manages is own CredHub version and should be upgraded separately.

## Upcoming Deprecations

### MySQLv1 and cf-mysql

PCF 2.4 will not support older versions of MySQL (cf-mysql and MySQL for PCF v1). Partner tiles that depend on this service should start [migrating to the MySQL for PCF v2 (pivotal-mysql) tile](https://docs.pivotal.io/p-mysql/2-2/migrate-to-v2.html). If your tile uses cf-mysql or p-mysql, you should:

1. Change your tile to use pivotal-mysql
2. Update your tile to declare a dependency on pivotal-mysql, and
3. Document a strategy for data migration.

### cflinuxfs2

In PAS 2.3, the cflinuxfs3 stack will be available alongside cflinuxfs2. In PCF 2.4, cflinuxfs3 will become the default stack. In PCF 2.5, the cflinuxfs2 stack will no longer be included. There are no plans to make cflinuxfs3 available as a patch release to PAS 2.2. **When Ubuntu 14.04 LTS becomes unsupported in April 2019, cflinuxfs2 will be removed from PAS 2.3+ in patch releases.**

**_If you are using tile generator, you will need to rebuild your tile for PAS 2.3._**

If you are **not** using tile generator and your tile contains errands that push applications (e.g. service brokers), you will need to adjust your errands.  Your apps should check the available stacks and use the cflinuxfs3 if it is available, otherwise using cflinuxfs2.  This change must be completed by PCF 2.4 when cflinuxfs3 becomes the default stack.

If your tile distributed buildpacks using cflinuxfs3, your tile should provide a separate buildpack with the same name for cflinuxfs3.

### Administrative tasks must use client credentials

Components today have errands and other tasks such as smoke tests and deploy scripts that use an internal user to perform administrative operations. These applications should move away from internal users and instead leverage client credentials.

This allows for disabling of internal users to meet customer compliance where they must not have service accounts and must use enterprise users (SAML or LDAP).  It also facilitates credential rotation and MFA enablement.

Service tile authors will need to complete this change by PCF 2.4.  Instructions for doing this change will be available after the 2.3 release.

## PCF 2.2 Compatibility Reminder

### BOSH DNS Default (Instead of Consul)

[BOSH DNS](https://bosh.io/docs/dns/) will be enabled by default, although Consul will still be available till the PCF 2.3 release (mid-September 2018).

## PCF 2.1 Compatibility Reminder

### Removal of IP accessors (.ips, .first_ip)

Tiles need to use BOSH links to retrieve IP addresses for other components.

#### Why is this important?

Customers want to do more automation using Ops Manager-generated manifests.  Today this is difficult because any IP Address Management (IPAM) done by Ops Manager can potentially conflict with changes made through the customer’s own automation. BOSH can now handle all IPAM. Using BOSH links, your software can receive IP addresses assigned by BOSH.

#### What do I need to do?

1. If you use tile-generator to build your tile, update to the latest version and rebuild.
2. If you have BOSH jobs defined in your tile, use dynamic_ips: 1 and static_ips: 0 for each job. This will use BOSH for IPAM instead of Ops Manager. (Note that “dynamic” is a bit overstated; BOSH will keep your job at the same IP address unless that is not possible, e.g., the operator changes the IP address range and that IP address is no longer available.)
3. If a BOSH release in your tile needs the IP address of another component, consume its BOSH link. In particular, IP address accessors like **the following will not be available in PCF 2.1**: \
`(( ..othertile.otherjob.first_ip ))`

```
(( ..othertile.otherjob.ips ))
(( .otherjob.first_ip ))
(( .otherjob.ips ))
(( first_ip ))
(( ips ))

```

4. If other components need your BOSH job’s IP address, provide a BOSH link.

For implementation details, please refer to the with-link examples in our [pcf-examples repository](https://github.com/cf-platform-eng/pcf-examples) and the [Tile Generator documentation](http://docs.pivotal.io/tiledev/tile-generator.html). For more background and context on BOSH links, see [BOSH Links: Why and How](https://gist.github.com/Amit-PivotalLabs/c39528248b8cdc4ba8e347f8aa68abb6) and the [official BOSH links documentation](https://bosh.io/docs/links.html).

## Questions?

Reach out to us on the Pivotal Partner Slack Team

**Forward Looking Statement.** 

<span class="fwd-looking-stmt">
This contains statements relating to Pivotal’s expectations, projections, beliefs and prospects which are "forward-looking statements” within the meaning of the federal securities laws and by their nature are uncertain. Words such as "believe," "may," "will," "estimate," "continue," "anticipate," "intend," "expect," "plans," and similar expressions are intended to identify forward-looking statements. Such forward-looking statements are not guarantees of future performance, and you are cautioned not to place undue reliance on these forward-looking statements. Actual results could differ materially from those projected in the forward-looking statements as a result of many factors, including but not limited to: (i) our limited operating history as an independent company, which makes it difficult to evaluate our prospects; (ii) the substantial losses we have incurred and the risks of not being able to generate sufficient revenue to achieve and sustain profitability; (iii) our future success depending in large part on the growth of our target markets; (iv) our future growth depending largely on Pivotal Cloud Foundry and our platform-related services; (v) our subscription revenue growth rate not being indicative of our future performance or ability to grow; (vi) our business and prospects being harmed if our customers do not renew their subscriptions or expand their use of our platform; (vii) any failure by us to compete effectively; (viii) our long and unpredictable sales cycles that vary seasonally and which can cause significant variation in the number and size of transactions that can close in a particular quarter; (ix) our lack of control of and inability to predict the future course of open-source technologies, including those used in Pivotal Cloud Foundry; and (x) any security or privacy breaches. All information set forth in this release is current as of the date of this release. These forward-looking statements are based on current expectations and are subject to uncertainties, risks, assumptions, and changes in condition, significance, value and effect as well as other risks disclosed previously and from time to time in documents filed by us with the U.S. Securities and Exchange Commission (SEC), including our prospectus dated April 19, 2018, and filed pursuant to Rule 424(b) under the U.S. Securities Act of 1933, as amended. Additional information will be made available in our quarterly report on Form 10-Q and other future reports that we may file with the SEC, which could cause actual results to vary from expectations. We disclaim any obligation to, and do not currently intend to, update any such forward-looking statements, whether written or oral, that may be made from time to time except as required by law.”
</span>