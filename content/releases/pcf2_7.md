# Pivotal Platform 2.7

Hello Pivotal Partners,

* Pivotal Application Service 2.7 has been released on [PivNet](https://network.pivotal.io/products/elastic-runtime#/releases/467372)

With this release, we have a handful of changes that require attention from tile authors.  See the complete list of breaking changes in the [release notes](https://docs.pivotal.io/platform/2-7/pcf-release-notes/breaking-changes.html)

PAS 2.4 release will move to End of General Support (EOGS) once PAS 2.7 is released.

## Pivotal Platform 2.7 Changes

### Tile CI Configuration

Some changes to Ops Manager 2.7 have impacted the tile configuration in our Tile CI system.
Ops Manager has become more selective about the configuration it accepts.
Here are two particular cases that have caused trouble:

- Ops Manager will reject the configuration if it includes properties underneath unselected options of a selector type property.
- Ops Manager will reject the configuration if it includes properties that have specified `configurable: false`.

Tile CI will give you a list of offending properties when it tries to configure your tile.
To fix the problem, navigate to the "Advanced" configuration tab for your tile, and simply remove the offending properties from the tile configuration.

### New GA Features

#### Ops Manager

* **[New Feature]**: BPM support in bosh, available in this Ops Manager.
* **[New Feature]**: A user is able to see information for stemcells in the Pending Changes API
  * Display all of the stemcell OS/Version information without keeping the existing stemcell_version key in a public-facing API
* **[New Feature]**: Pivotal tiles present platform operators with a consistent syslog configuration form
  * Certain tiles currently implement their own syslog (RFC 5426) config requiring Alana to enable logs in dozens of places, leading to missed logs.
  * OpsMgr has created a form for consistency, and [tiles can opt into it](https://docs.pivotal.io/tiledevmigrating-syslog-configuration.html) provided they don't need additional fields.

#### PAS

### Features

* App developer can [run a sidecar](https://docs.run.pivotal.io/devguide/sidecars.html) as a first-class process in application instances.
* On-Demand Service Broker Granular Upgrades
  * Pivotal released "upgrade-one" for the on-demand broker which allows the operator to initiate a single-instance upgrade; useful for data services team
    * [On-Demand Services SDK](https://docs.pivotal.io/svc-sdk/odb/0-31/management.html#upgrade-all-service-instances) documentation is being updated
* Pivotal Tiles use compiled instead of non-compiled components so that updates don't surprise operators
  * Speed: Tiles should use compiled packages so that updates are faster
  * Stability: By using compiled components, Tiles that share commonly used component packages won't run into unnecessary VM updates across the entire foundation.

### Beta Features

#### Ops Manager

* Operators using a Service Broker can see the Service Broker syslogs in Ops Manager.

### Upcoming Deprecations

* BOSH is removing support for v1 manifests (**BREAKING CHANGE**)
  * v1 manifests will stop working in [BOSH DIR v270.0.0](https://github.com/cloudfoundry/bosh/releases/tag/v270.0.0) and this will be a **breaking change** for anyone still using v1 manifest.
  * We do not expect this to affect most tiles as Ops Manager is responsible for BOSH manifest generation.
* Replace `uaa.port` with `uaa.ssl.port` (**BREAKING CHANGE**)
  * UAA is disallowing incoming HTTP traffic from UAA to the OM, PAS, and PKS databases. UAA now only supports HTTPS and platform component teams will need to use uaa.ssl.port.
* Deprecating the firehose
  * Log Cache is replacing the firehose for logs, in the PAS 2.7 timeframe, the firehose should be considered deprecated.
  * See the notice below for details.
* Remove ETCD and Consul: Final mile to remove consul from all tiles
  * Final clean up for all teams to remove consul to remove tech debt and complexity from the platform

## Notice for Partners with Nozzles

The v1 nozzle endpoint is being deprecated in December. v1 nozzles will not work after this date. This change will likely arrive in PAS version 2.8, which will likely be released in December 2019.

You may already be using the v2 API, we’re communicating this broadly to ensure that no partners are missed.

To help with this transition, our team has built v2 API examples in the GitHub repository [firehose-nozzle-v2](https://github.com/cf-platform-eng/firehose-nozzle-v2). There are two ways of connecting: the Reverse Log Proxy (RLP) and the Reverse Log Proxy Gateway (RLP Gateway). We recommend using the Gateway, as the deployment and authentication model is simpler (a BOSH release isn’t required and the nozzle can be deployed as an app when using the RLP Gateway). The above repository contains code samples for both methods, but only packages the Gateway based solution into a tile.

Reverse Log Proxy Gateway support was added in PAS 2.4.  Pivotal support policies (n-2 release) should allow this support to be widespread by the September release of PAS 2.7.

The payload will be slightly different, so translation into your system of record will require code changes. The [loggregator API documentation describes](https://github.com/cloudfoundry/loggregator-api/blob/master/README.md#v2---v1-mapping) a mapping between the v1 and v2 payload.

If you’re unsure what version of the API you’re consuming, check the Golang dependencies. Using noaa and sonde-go indicates is the v1 API. The v2 API uses either go-loggregator or, for a Gateway based solution, potentially no Cloud Foundry specific libraries.

The [firehose-to-syslog project](https://github.com/cloudfoundry-community/firehose-to-syslog) is a more complex, real-world example that was migrated from v1 to v2 via [this pull request](https://github.com/cloudfoundry-community/firehose-to-syslog/pull/213).

Migrating to v2 does carry additional advantages:

* V2 moves away from WebSockets for communication, which caused issues with load balancers.
* V2 adds the ability to filter messages at source, which can greatly reduce the amount of data ingested. The model is no longer accept everything and discard.
* V2 reduces messages loss.

Additional resources to help with this transition:

* The [mailing list thread](https://lists.cloudfoundry.org/g/cf-dev/topic/proposal_deprecation_of_the/29741830?p=,,,20,0,0,0::recentpostdate%2Fsticky,,,20,2,0,29741830) proposing and discussing the deprecation
* The [RLP Gateway docs](https://github.com/cloudfoundry/loggregator/blob/master/docs/rlp_gateway.md)
* The [README for cf-platform-eng/firehose-nozzle-v2](https://github.com/cf-platform-eng/firehose-nozzle-v2/blob/master/README.md) contains additional reference material and details.

## Questions?

Reach out to us on the Pivotal Partner Slack Team or at [ISV-TPM@pivotal.io](mailto:ISV-TPM@pivotal.io).  As a note, Jake Knotsman has rolled off to another team at Pivotal so direct your questions to Marina, Ted, or Andrew.

**Forward Looking Statement**

<span class="fwd-looking-stmt">
This contains statements relating to Pivotal’s expectations, projections, beliefs and prospects which are "forward-looking statements" within the meaning of the federal securities laws and by their nature are uncertain. Words such as "believe," "may," "will," "estimate," "continue," "anticipate," "intend," "expect," "plans," and similar expressions are intended to identify forward-looking statements. Such forward-looking statements are not guarantees of future performance, and you are cautioned not to place undue reliance on these forward-looking statements. Actual results could differ materially from those projected in the forward-looking statements as a result of many factors, including but not limited to: (i) our limited operating history as an independent company, which makes it difficult to evaluate our prospects; (ii) the substantial losses we have incurred and the risks of not being able to generate sufficient revenue to achieve and sustain profitability; (iii) our future success depending in large part on the growth of our target markets; (iv) our future growth depending largely on Pivotal Cloud Foundry and our platform-related services; (v) our subscription revenue growth rate not being indicative of our future performance or ability to grow; (vi) our business and prospects being harmed if our customers do not renew their subscriptions or expand their use of our platform; (vii) any failure by us to compete effectively; (viii) our long and unpredictable sales cycles that vary seasonally and which can cause significant variation in the number and size of transactions that can close in a particular quarter; (ix) our lack of control of and inability to predict the future course of open-source technologies, including those used in Pivotal Cloud Foundry; and (x) any security or privacy breaches. All information set forth in this release is current as of the date of this release. These forward-looking statements are based on current expectations and are subject to uncertainties, risks, assumptions, and changes in condition, significance, value and effect as well as other risks disclosed previously and from time to time in documents filed by us with the U.S. Securities and Exchange Commission (SEC), including our prospectus dated April 19, 2018, and filed pursuant to Rule 424(b) under the U.S. Securities Act of 1933, as amended. Additional information will be made available in our quarterly report on Form 10-Q and other future reports that we may file with the SEC, which could cause actual results to vary from expectations. We disclaim any obligation to, and do not currently intend to, update any such forward-looking statements, whether written or oral, that may be made from time to time except as required by law."
</span>

<!-- Docs to Markdown version 1.0β17 -->
