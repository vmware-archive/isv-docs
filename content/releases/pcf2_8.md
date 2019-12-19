# Pivotal Platform 2.8

Hello Pivotal Partners,

* Pivotal Application Service 2.8 has been released on [PivNet](https://network.pivotal.io/products/elastic-runtime#/releases/467372)

* With this release, we have a handful of changes that require attention from tile authors.  See the complete list of breaking changes in the [release notes](https://docs.pivotal.io/platform/2-8/pcf-release-notes/breaking-changes.html)

* PAS 2.5 release will move to End of General Support (EOGS) once PAS 2.8 is released.

* Pivotal Cloud Foundry (PCF) has been rebranded to Pivotal Platform. All partner docs repos have been rebranded. We ask partners update their own documentation and diagrams referring to ‘PCF’ or “Pivotal Cloud Foundry”

## Pivotal Platform 2.8 Changes

### New GA Features

#### Ops Manager

* Products can declare optional dependencies
    * This will allow horizontal scaling by externalizing the session, but will increase the volume of database reads/writes. Sessions will be maintained in the event of UAA downtime.
  
* For tiles with 'collection' type properties, especially for service plans:
    * [Platform Automation](https://network.pivotal.io/products/platform-automation/) for PCF requires a `name` field on collection elements in order to differentiate between updates to existing elements and deleting/adding an element. Please include a `name` field in your collection if this affects your functionality. See the related [GitHub issue](https://github.com/pivotal-cf/om/issues/207) for more details.
  
* Ops Manager will consume Maestro’s CLI
    * Ops Manager will consume Maestro’s CLI to allow customers to complete a full rotation for all certificates managed by Ops Manager and CredHub in one single flow. BOSH property credhub.certificates.concatenate_cas will be set to true by default in 2.8.  This means that CAs will be returned concatenated, which means tiles must be configured to return concatenated CAs, and be able to handle concatenated CAs. For more details, please see [Maestro Tile Inspection](https://docs.google.com/document/d/1JBjkvKYbI4aOobX9lf-sqrnxhKYpJ8JLlsdOeYF-uPg/edit).
  
* Pivotal Tiles present Alana with a consistent syslog config form
    * We've seen that customers don't enable logging until something goes wrong and this makes it easier for them to enable logging from the get-go.
    * If you are a tile team please use the default OpsMan form for enabling Syslog. This needs to be made available as part of each tile's configuration. (Note that even ODB teams can use the OpsMan form as of OM 2.6

### Upcoming Deprecations

* Firehose Deprecation
    * Log Cache is replacing the firehose for logs, in the Pivotal Platform 2.7 timeframe, the firehose should be considered deprecated
    * See the notice below for details.
  
* Maestro's CLI will be consumed by Ops Manager

## Questions

Reach out to us on the Pivotal Partner Slack Team or at [ISV-TPM@pivotal.io](mailto:ISV-TPM@pivotal.io).  As a note, Jake Knotsman has rolled off to another team at Pivotal so direct your questions to Marina, Ted, or Andrew.

**Forward Looking Statement**

<span class="fwd-looking-stmt">
This contains statements relating to Pivotal’s expectations, projections, beliefs and prospects which are "forward-looking statements" within the meaning of the federal securities laws and by their nature are uncertain. Words such as "believe," "may," "will," "estimate," "continue," "anticipate," "intend," "expect," "plans," and similar expressions are intended to identify forward-looking statements. Such forward-looking statements are not guarantees of future performance, and you are cautioned not to place undue reliance on these forward-looking statements. Actual results could differ materially from those projected in the forward-looking statements as a result of many factors, including but not limited to: (i) our limited operating history as an independent company, which makes it difficult to evaluate our prospects; (ii) the substantial losses we have incurred and the risks of not being able to generate sufficient revenue to achieve and sustain profitability; (iii) our future success depending in large part on the growth of our target markets; (iv) our future growth depending largely on Pivotal Cloud Foundry and our platform-related services; (v) our subscription revenue growth rate not being indicative of our future performance or ability to grow; (vi) our business and prospects being harmed if our customers do not renew their subscriptions or expand their use of our platform; (vii) any failure by us to compete effectively; (viii) our long and unpredictable sales cycles that vary seasonally and which can cause significant variation in the number and size of transactions that can close in a particular quarter; (ix) our lack of control of and inability to predict the future course of open-source technologies, including those used in Pivotal Cloud Foundry; and (x) any security or privacy breaches. All information set forth in this release is current as of the date of this release. These forward-looking statements are based on current expectations and are subject to uncertainties, risks, assumptions, and changes in condition, significance, value and effect as well as other risks disclosed previously and from time to time in documents filed by us with the U.S. Securities and Exchange Commission (SEC), including our prospectus dated April 19, 2018, and filed pursuant to Rule 424(b) under the U.S. Securities Act of 1933, as amended. Additional information will be made available in our quarterly report on Form 10-Q and other future reports that we may file with the SEC, which could cause actual results to vary from expectations. We disclaim any obligation to, and do not currently intend to, update any such forward-looking statements, whether written or oral, that may be made from time to time except as required by law."
</span>

<!-- Docs to Markdown version 1.0β17 -->
