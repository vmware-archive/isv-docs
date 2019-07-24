# PCF 2.5 / PKS 1.4

Hello Pivotal Partners,

PCF 2.5 is scheduled for release in March. With this release, we have a handful of changes that require attention from tile authors.

## PCF 2.5 Breaking Changes

### Minimum supported Stemcells version is Xenial

Canonical will end support for Ubuntu Trusty Tahr on April 30th, 2019 and security fixes will no longer be backported.  Tile authors should **immediately** start testing with the Xenial stemcells and fix any compatibility issues.

**As of February 15th, we will not publish new partner product releases on PivNet, unless they support Xenial stemcells.**

**Starting April 30th, 2019, we will be retiring all partner products that require a Trustry stemcell from PivNet.**

Xenial stemcells are available on [Pivotal Network](https://network.pivotal.io/).

See _“Xenial Stemcells”_ in the **PCF 2.4 Compatibility Reminder** section for more details.

### Apps must use cflinuxfs3 stack

In PAS 2.5, cflinuxfs3 will be the **_only_** stack underneath `cf push`ed applications. Use the latest Tile Generator updates to enable cflinuxfs3.

See _“Migrate cflinuxfs2 apps over to cflinuxfs3”_ in the **PCF 2.4 Compatibility Reminder** section for full details on this **now** breaking change.


### Ops Manager defaults to Availability Zones in Azure for clean installs

*   We now default to Availability Zones in Azure for clean installs. This will break your CI if you’re not in a region that supports AZs (7 global regions do). You can always go back to avail sets, but we’d prefer you switch regions instead. \

### Ops Manager has renamed its files on PivNet, and is actually using 3-digit version numbers everywhere

*   In order to standardize filenames to the requested scheme from platform automation, OM has renamed all of its files to contain the product slug and a full 3 digit version number like so: \
	OpsManager2.5-build.128onGCP.yml **is now** ops-manager-gcp-2.5.0-build.128.yml
*   The reported product version in the API/UI will now have 3 digits as well, though alphas/beta/RCs will all be 2.5.0 (with an increasing build number after the patch).

## New Features in Ops Manager

*   **[New Feature]**: Tile authors can now implement user-facing warnings that display when a pre-delete or post-deploy errand is implemented. Use the impact_warning key in pre_delete_errands or post_deploy_errands to specify a warning.
*   **[New Feature]**: You can now change a selected option of a selector with the API using the human-readable name of the option. Send a PUT to /api/v0/staged/products/:GUID/properties with a selected_option key. The PUT API endpoint can also parse both value, for the human-readable value, and option_value, for the machine-readable value.
*   **[New Feature]**: You can now use ((cpu)) as a double-parens job accessor to interpolate the CPU value in a manifest.
*   **[New Feature]**: Tile authors can now use a double-parens accessor to pull information from Ops Manager. Use the (($ops_manager.restricted_view_api_access_credentials)) accessor to make read-only, non-credential requests to Ops Manager.
*   **[New Feature]**: Tile authors can access a catalog of available VM types with the (($ops_manager.instance_types_catalog)) accessor.
*   **[New Feature]**: You can provide custom rsyslog configurations in the **Syslog** form.
*   **[New Feature]**: Tile authors can write and apply JS migrations to migrate data from their existing syslog configurations to Ops Manager’s template syslog form. For more information, see [opsmanager_syslog](https://docs.pivotal.io/tiledev/2-4/property-template-references.html#syslog-flag) in the Tile Developer docs.

## Upcoming Deprecations for Future Releases

### Metron Agent Eventually Going Away

The loggregator-agent release is the new drop-in replacement to replace metron.  In PAS 2.5, metron agent will disappear and you will have to update your BOSH manifest to use the [loggregator-agent release](https://bosh.io/releases/github.com/cloudfoundry/loggregator-agent-release?all=1) instead.

### Use UAA Client Credentials Instead of Admin Users

The introduction of `cf auth --client-credentials` allows components using `cloud_controller.admin` to leverage a client instead of a user. PCF 2.5 will include a set of `tile_installer_client` credentials to bootstrap client credentials for long-term use, instead of using shared admin-level credentials. In a future version of PCF, you must comply with not using an Admin user.

The benefits of this include supporting customers who need to use two-factor authentication for users, disabling internal users to meet compliance regulations, and better support for credential rotation.

### PAS Components Moving to BPM

Internal PAS components are migrating to [BOSH Process Manager (BPM)](https://bosh.io/docs/bpm/bpm/) as of PCF 2.5 to keep jobs simpler, boilerplate-free, and isolated from one another so processes cannot leak data to each other. This should be transparent for most partner products, but will change the structure of internal PAS component deployments. **_Partners may also look to use BPM in their own BOSH releases._**

### ODB SDK Recreate All Services Instances Errand

When an OpsManager root CA is rotated and new non-configurable certificates generated, OpsManager can force a recreate of BOSH VMs so that they will contain the new root CA. However, it has no knowledge of VMs created by On-Demand Brokers.

In order to allow recreate these Service Instance VMs behind On-Demand Brokers, it was decided that we would provide a new errand called Recreate All Service Instances on the ODB release. That errand would re-create all the VMs created by ODB in order to force the CA certificate rotation.

## PKS 1.4 New Features

We are targeting PKS 1.4 for a mid-April release.  Date TBD pending when two of the three major IaaSs release their K8s 1.13 compatible version.  

### Kubernetes 1.13

PKS 1.4 will support K8s 1.13.  Known changes in K8s 1.13 can be found here: [https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.13.md](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.13.md)

### PKS 1.4 planned to be the first PKS version where you can run PKS and PAS in the same OM

This is currently not a supported configuration but will be with the release of PKS 1.4.

### Windows Worker Support (Beta)

PKS 1.4 intends to add Windows workers support as a beta feature. This will allow PKS workloads to be deployed on Windows.   

This is subject to change until the release date.  

PKS 1.4 will be compatible with Ops Manager 2.5.

## PCF 2.4 Compatibility Reminder

### Credhub 2.0 (Applications)

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

Canonical will end support for Ubuntu Trusty Tahr on April 30th, 2019 and security fixes will no longer be backported.  PCF is transitioning to use stemcells based on Xenial Xerus and will no longer support Trusty stemcells in PCF 2.5.  Tile authors should start testing with the Xenial stemcells and fix any compatibility issues.

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

## PCF 2.3 Compatibility Reminder

### BOSH DNS Adoption (Consul Server Removed)

In PCF 2.3, Consul server will be removed and [BOSH DNS](https://bosh.io/docs/dns/) will be used instead.  Tile authors should start the process of removing Consul **agents**, which needs to be completed by PCF 2.4. Consul will be completely removed by PCF 2.5.

### Credhub (Service Broker / Bosh Releases)

Credhub 2.0 will be available for PCF 2.3 and may affect partner tiles in three areas:


1. Ops Manager will act as the CredHub client, and the tile can continue to use the  \
``((( VARIABLE )))`` syntax for templating.  This should not affect most tile authors.
2. If your tile includes a service broker that uses the [secure credentials workflow](https://github.com/cloudfoundry-incubator/credhub/blob/master/docs/secure-service-credentials.md#updated-service-workflow), that service broker would act as a CredHub client and will need updating. Likewise, if a tile includes an app that uses this workflow, that app would act as a CredHub client and will need updating.
3. If your tile includes its own CredHub instance, this not affected by this upgrade.  Your tile manages is own CredHub version and should be upgraded separately

## Questions?

Reach out to us on the Pivotal Partner Slack Team

**Forward Looking Statement.** This contains statements relating to Pivotal’s expectations, projections, beliefs and prospects which are "forward-looking statements” within the meaning of the federal securities laws and by their nature are uncertain. Words such as "believe," "may," "will," "estimate," "continue," "anticipate," "intend," "expect," "plans," and similar expressions are intended to identify forward-looking statements. Such forward-looking statements are not guarantees of future performance, and you are cautioned not to place undue reliance on these forward-looking statements. Actual results could differ materially from those projected in the forward-looking statements as a result of many factors, including but not limited to: (i) our limited operating history as an independent company, which makes it difficult to evaluate our prospects; (ii) the substantial losses we have incurred and the risks of not being able to generate sufficient revenue to achieve and sustain profitability; (iii) our future success depending in large part on the growth of our target markets; (iv) our future growth depending largely on Pivotal Cloud Foundry and our platform-related services; (v) our subscription revenue growth rate not being indicative of our future performance or ability to grow; (vi) our business and prospects being harmed if our customers do not renew their subscriptions or expand their use of our platform; (vii) any failure by us to compete effectively; (viii) our long and unpredictable sales cycles that vary seasonally and which can cause significant variation in the number and size of transactions that can close in a particular quarter; (ix) our lack of control of and inability to predict the future course of open-source technologies, including those used in Pivotal Cloud Foundry; and (x) any security or privacy breaches. All information set forth in this release is current as of the date of this release. These forward-looking statements are based on current expectations and are subject to uncertainties, risks, assumptions, and changes in condition, significance, value and effect as well as other risks disclosed previously and from time to time in documents filed by us with the U.S. Securities and Exchange Commission (SEC), including our prospectus dated April 19, 2018, and filed pursuant to Rule 424(b) under the U.S. Securities Act of 1933, as amended. Additional information will be made available in our quarterly report on Form 10-Q and other future reports that we may file with the SEC, which could cause actual results to vary from expectations. We disclaim any obligation to, and do not currently intend to, update any such forward-looking statements, whether written or oral, that may be made from time to time except as required by law.”
