# Pivotal Platform 2.9

*   Pivotal Platform 2.9 is scheduled for release in early-April.  With this release, we have a handful of changes that require attention from tile authors.
*   Pivotal Platform 2.6 will move to End of General Support (EOGS) once 2.9 is released.
*   Releases of Pivotal Platform moving forward will be rebranded to VMware Tanzu


## New GA Features


### Ops Manager:


*   **Operators should discover invalid crontab schedules earlier**
    *   Changing the feedback loop from hours to seconds by finding about before the deployment kicks off
    *   Redis team requested this feature for their customers when customers are trying to back up their instance. This is a customer problem that affects many tiles.
    *   With Pivotal Platform 2.6 moving to EOGS, this change which first shipped in Pivotal Platform 2.7 will be relevant across all supported versions.

*   **Buildpack changes**
    *   These are changes to the buildpacks shipped by default in Pivotal Platform 2.9:
        *   Support for Node 8.0 removed
        *   Python 2.7 removed
        *   .Net-runtime v3.x removed

*   **Products can declare optional dependencies**
    *   OpsManager will provide:
        *   The ability to mark a product dependency as optional
        *   The ability to declare the default values for properties when a product dependency is staged
        *   The ability to check if a product dependency is satisfied in order to craft the correct manifest
        *   Changes to the Review Pending Changes UI to distinguish required dependencies from optional dependencies

*   **Enable use of special characters within the client secret (URI Encoding)** 
    *   Previously UAA was not able to provide tokens for clients that used a special character within their client secret.
    *   UAA will be set to run in Compatibility mode for Pivotal Platform 2.8, hence any components used to the UAA behavior before version v74.0.0 will not be required to make any change.
    *   For components that have already started using UAA versions >= v74.0.0, and have accommodated the encoding changes, will need to begin use of the `X-CF-ENCODED-CREDENTIALS=true` header


## New Beta Features

*   **Customer can function without the firehose**
    *   All critical platform components scrape a Log Cache endpoint for logs when needed, rather than subscribing to a nozzle from the firehose
    *   V2 Firehose (RLP/RLP Gateway, as mentioned below) is what's being moved to in 2.10 specifically; syslog/prometheus endpoints are the next step past that
    *   Why we are doing this: plan to entirely deprecate the v1 Loggregator architecture by Pivotal Platform 2.11, along with its complexity and brittleness


## Upcoming Deprecations

### Ops Manager:

*   **Supporting domain-style S3 paths:**
    *   [Amazon S3 Path Deprecation Plan](https://aws.amazon.com/blogs/aws/amazon-s3-path-deprecation-plan-the-rest-of-the-story/) from Amazon by September 30, 2020
    *   Pivotal recommends making your products configurable, such that they  support both styles, and let the operator choose.


### Pivotal Platform:

*   **Firehose/Loggregator:**
    *   V1 firehose is off by default in 2.10
    *   V1 firehose will be removed from 2.11
    *   Also see notes below on the Observability Fabric 


## Notice for Partners with Nozzles:

The v1 nozzle endpoint is being deprecated in 2.10. v1 nozzles will not work after this date.

You may already be using the v2 API, we’re communicating this broadly to ensure that no partners are missed.

To help with this transition, our team has built v2 API examples in the GitHub repository[ https://github.com/cf-platform-eng/firehose-nozzle-v2](https://github.com/cf-platform-eng/firehose-nozzle-v2), and production implementations should base their solution on go-loggregator’s RLPGatewayClient [https://github.com/cloudfoundry/go-loggregator/blob/master/rlp_gateway_client.go](https://github.com/cloudfoundry/go-loggregator/blob/master/rlp_gateway_client.go). There are two ways of connecting: the Reverse Log Proxy (RLP) and the Reverse Log Proxy Gateway (RLP Gateway). We recommend using the Gateway, as the deployment and authentication model is simpler (a BOSH release isn’t required and the nozzle can be deployed as an app when using the RLP Gateway). The above repository contains code samples for both methods, but only packages the Gateway based solution into a tile.

Reverse Log Proxy Gateway support was added to PCF 2.4.  Pivotal support policies (n-2 release) allowed this support to be widespread by the September release of PCF 2.7.

The payload will be slightly different, so translation into your system of record will require code changes. The[ loggregator API documentation describes](https://github.com/cloudfoundry/loggregator-api/blob/master/README.md#v2---v1-mapping) a mapping between the v1 and v2 payload.

If you’re unsure what version of the API you’re consuming, check the Golang dependencies. Using noaa and sonde-go indicates is the v1 API. The v2 API uses either go-loggregator or, for a Gateway based solution, potentially no Cloud Foundry specific libraries.

The[ firehose-to-syslog project](https://github.com/cloudfoundry-community/firehose-to-syslog) is a more complex, real-world example that was migrated from v1 to v2 via[ this pull request](https://github.com/cloudfoundry-community/firehose-to-syslog/pull/213).

Migrating to v2 does carry additional advantages:


*   V2 moves away from WebSockets for communication, which caused issues with load balancers.
*   V2 adds the ability to filter messages at source, which can greatly reduce the amount of data ingested. The model is no longer accept everything and discard.
*   V2 reduces messages loss.

Additional resources to help with this transition:



*   The[ mailing list thread](https://lists.cloudfoundry.org/g/cf-dev/topic/proposal_deprecation_of_the/29741830?p=,,,20,0,0,0::recentpostdate%2Fsticky,,,20,2,0,29741830) proposing and discussing the deprecation
*   The[ RLP Gateway docs](https://github.com/cloudfoundry/loggregator/blob/master/docs/rlp_gateway.md)
*   The[ README for cf-platform-eng/firehose-nozzle-v2](https://github.com/cf-platform-eng/firehose-nozzle-v2/blob/master/README.md) contains additional reference material and details.

The Observability Fabric:

*   [The Observability Fabric](https://docs.pivotal.io/platform/application-service/2-8/loggregator/observability-fabric.html) was introduced in 2.8 as beta
*   The Observability Fabric remains in beta.
*   It is recommended that Partner’s familiarize themselves with the Observability Fabric as it will eventually replace V2 nozzles


## Questions?

Reach out to us on the Pivotal Partner Slack Team or at [ISV-TPM@pivotal.io](mailto:ISV-TPM@pivotal.io).  

**Forward-Looking Statement.** This contains statements relating to Pivotal’s expectations, projections, beliefs and prospects which are "forward-looking statements” within the meaning of the federal securities laws and by their nature are uncertain. Words such as "believe," "may," "will," "estimate," "continue," "anticipate," "intend," "expect," "plans," and similar expressions are intended to identify forward-looking statements. Such forward-looking statements are not guarantees of future performance, and you are cautioned not to place undue reliance on these forward-looking statements. Actual results could differ materially from those projected in the forward-looking statements as a result of many factors, including but not limited to: (i) our limited operating history as an independent company, which makes it difficult to evaluate our prospects; (ii) the substantial losses we have incurred and the risks of not being able to generate sufficient revenue to achieve and sustain profitability; (iii) our future success depending in large part on the growth of our target markets; (iv) our future growth depending largely on Pivotal Cloud Foundry and our platform-related services; (v) our subscription revenue growth rate not being indicative of our future performance or ability to grow; (vi) our business and prospects being harmed if our customers do not renew their subscriptions or expand their use of our platform; (vii) any failure by us to compete effectively; (viii) our long and unpredictable sales cycles that vary seasonally and which can cause significant variation in the number and size of transactions that can close in a particular quarter; (ix) our lack of control of and inability to predict the future course of open-source technologies, including those used in Pivotal Cloud Foundry; and (x) any security or privacy breaches. All information set forth in this release is current as of the date of this release. These forward-looking statements are based on current expectations and are subject to uncertainties, risks, assumptions, and changes in condition, significance, value and effect as well as other risks disclosed previously and from time to time in documents filed by us with the U.S. Securities and Exchange Commission (SEC), including our prospectus dated April 19, 2018, and filed pursuant to Rule 424(b) under the U.S. Securities Act of 1933, as amended. Additional information will be made available in our quarterly report on Form 10-Q and other future reports that we may file with the SEC, which could cause actual results to vary from expectations. We disclaim any obligation to, and do not currently intend to, update any such forward-looking statements, whether written or oral, that may be made from time to time except as required by law.”
