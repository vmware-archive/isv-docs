# PCF 2.6 / PKS 1.5

Hello Pivotal Partners,

*   PCF 2.6 is scheduled for release in June
*   PKS 1.5 is scheduled for release in July

With this release, we have a handful of changes that require attention from tile authors.

PAS releases 2.3 will move to End of General Support (EOGS) with this release.

## PCF 2.6 Changes

### New GA Features

#### Ops Manager

*   **[New Feature]**: BPM support in bosh, available in this Ops Manager.
*   **[New Feature]**: Drain Lifecycle updates to help improve deployment orchestration.
*   **[New Feature]**: Operators using a Service Broker (SB) should be able to see the SB logs in OM’s syslog via runtime config.
*   **[New Feature]**: Ops Manager API users can now call an endpoint to receive a list of required fields for product configuration.
*   **[New Feature]: **Multiple stemcells per tile is now possible, _however, Tile Generator does not yet support this._

#### PAS

### Beta Features

*   App Developers can easily rollback to an app revision from a specific point in time.
*   Operators can now obtain additional IAAS VM metrics via the Loggregator Firehose.
*   App Operators can set up more than 10k syslog drains.
*   Sidecar support for Diego Cell based applications.  [See CF Blog](https://www.cloudfoundry.org/blog/how-to-push-an-app-to-cloud-foundry-with-sidecars/).

### ODB SDK Changes

The latest version of the [ODB SDK (v0.29.1)](https://github.com/pivotal-cf/on-demand-service-broker-release/releases/tag/v0.29.1) has been released.  

#### ODB SDK Recreate All Services Instances Errand

When an Ops Manager root CA is rotated and new non-configurable certificates are generated, OpsManager can force a recreate of BOSH VMs so that they will contain the new root CA. However, it has no knowledge of VMs created by On-Demand Brokers.

In order to recreate these Service Instance VMs behind On-Demand Brokers, it was decided that we would provide a new errand called Recreate All Service Instances on the ODB release. That errand would re-create all the VMs created by ODB in order to force the CA certificate rotation.

If you are running on an older release of the ODB SDK, please upgrade to the latest release to take advantage of these features.

### Upcoming Deprecations

#### Upgrade Spring Boot 1.0 App Brokers to Spring Boot 2.0 {#upgrade-spring-boot-1-0-app-brokers-to-spring-boot-2-0}

[Spring Boot 1.0 EOL is coming August 1, 2019](https://spring.io/blog/2018/07/30/spring-boot-1-x-eol-aug-1st-2019).  Any apps or app brokers should be updated to Spring Boot 2.0 to stay current with security patches and general support by the Spring Team.

#### Metron Agent Eventually Going Away

The loggregator-agent release is the new drop-in replacement to replace metron.  In PAS 2.5, metron agent will disappear and you will have to update your BOSH manifest to use the [loggregator-agent release](https://bosh.io/releases/github.com/cloudfoundry/loggregator-agent-release?all=1) instead.

#### Use UAA Client Credentials Instead of Admin Users

The introduction of `cf auth --client-credentials` allows components using `cloud_controller.admin` to leverage a client instead of a user. PCF 2.5 will include a set of `tile_installer_client` credentials to bootstrap client credentials for long-term use, instead of using shared admin-level credentials.

The benefits of this include supporting customers who need to use two-factor authentication for users, disabling internal users to meet compliance regulations, and better support for credential rotation.

As the details of this develop, we plan to enhance Tile Generator to help make this process smoother. In the meantime, if you would like more information, please reach out to us in Pivotal Partners Slack.

## PKS 1.5 Changes

PKS is scheduled for release in July 2019.

Turnkey solution

Windows based workloads

Multi-cluster/ Fleet Management

Granular Upgrades

Leverage SAML for authentication

Observability

Monitor namespace through metrics sink

Platform Resilience & High Availability

Highly Available UAA

Enterprise Security & Networking

K8s Ingress leveraging Istio

Conformance

Kubernetes V1.14.x

## Other Pivotal Product Announcements

*   Concourse 5.1 released as GA
*   Spring Boot 1.0 will be [deprecated](https://spring.io/blog/2018/07/30/spring-boot-1-x-eol-aug-1st-2019) August 1, 2019

## Questions?

Reach out to us on the Pivotal Partner Slack Team

**Forward Looking Statement.** This contains statements relating to Pivotal’s expectations, projections, beliefs and prospects which are "forward-looking statements” within the meaning of the federal securities laws and by their nature are uncertain. Words such as "believe," "may," "will," "estimate," "continue," "anticipate," "intend," "expect," "plans," and similar expressions are intended to identify forward-looking statements. Such forward-looking statements are not guarantees of future performance, and you are cautioned not to place undue reliance on these forward-looking statements. Actual results could differ materially from those projected in the forward-looking statements as a result of many factors, including but not limited to: (i) our limited operating history as an independent company, which makes it difficult to evaluate our prospects; (ii) the substantial losses we have incurred and the risks of not being able to generate sufficient revenue to achieve and sustain profitability; (iii) our future success depending in large part on the growth of our target markets; (iv) our future growth depending largely on Pivotal Cloud Foundry and our platform-related services; (v) our subscription revenue growth rate not being indicative of our future performance or ability to grow; (vi) our business and prospects being harmed if our customers do not renew their subscriptions or expand their use of our platform; (vii) any failure by us to compete effectively; (viii) our long and unpredictable sales cycles that vary seasonally and which can cause significant variation in the number and size of transactions that can close in a particular quarter; (ix) our lack of control of and inability to predict the future course of open-source technologies, including those used in Pivotal Cloud Foundry; and (x) any security or privacy breaches. All information set forth in this release is current as of the date of this release. These forward-looking statements are based on current expectations and are subject to uncertainties, risks, assumptions, and changes in condition, significance, value and effect as well as other risks disclosed previously and from time to time in documents filed by us with the U.S. Securities and Exchange Commission (SEC), including our prospectus dated April 19, 2018, and filed pursuant to Rule 424(b) under the U.S. Securities Act of 1933, as amended. Additional information will be made available in our quarterly report on Form 10-Q and other future reports that we may file with the SEC, which could cause actual results to vary from expectations. We disclaim any obligation to, and do not currently intend to, update any such forward-looking statements, whether written or oral, that may be made from time to time except as required by law.”
