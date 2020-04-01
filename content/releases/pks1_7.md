### Breaking Changes

Enterprise PKS v1.7.0 has the following breaking changes:


#### **Removal of the Dashboard UI**

Clusters created with PKS v1.7 do not have Dashboard installed on creation. For more information, see the [Kubernetes Control Plane](https://docs-pcf-staging.cfapps.io/pks/1-7/release-notes.html#1-7-0-bosh-lifecycle) section.


#### **Removal of API Version Definitions in Kubernetes v1.16**

The bump to Kubernetes v1.16 removes some API version definitions in favor of newer, more stable definitions. This change may break some integrations, controllers, and pipelines. For more information, see the [Kubernetes Control Plane](https://docs-pcf-staging.cfapps.io/pks/1-7/release-notes.html#1-7-0-bosh-lifecycle) section.


#### **Enterprise PKS Database Migration**

This release migrates the Enterprise PKS control plane database from the PKS API VM to a new instance group, PKS Database.

Enterprise PKS performs the database migration as part of your Enterprise PKS upgrade to v1.7. During the upgrade, the Enterprise PKS control plane and the PKS CLI will be unavailable. Your Kubernetes workloads remain accessible throughout the upgrade.

To upgrade to Enterprise PKS v1.7, follow the instructions in [Upgrading Enterprise PKS](https://docs-pcf-staging.cfapps.io/pks/1-7/upgrade-pks.html) or [Upgrading Enterprise PKS with NSX-T](https://docs-pcf-staging.cfapps.io/pks/1-7/upgrade-pks-nsxt.html).

These topics contain important preparation and upgrade configuration steps you must follow before and during your upgrade to v1.7.


### Known Issues

Enterprise PKS v1.7.0 has the following known issues:


#### 502 Bad Gateway After OIDC Login

**Symptom**

You experience a “502 Bad Gateway” error from the NSX load balancer after you log in to OIDC.

**Explanation**

A large response header has exceeded your NSX-T load balancer maximum response header size. The default maximum response header size is 10,240 characters and should be resized to 50,000.

**Workaround**

If you experience this issue, manually reconfigure your NSX-T `request_header_size` and `response_header_size` to 50,000 characters. For information about configuring NSX-T default header sizes, see [OIDC Response Header Overflow](https://community.pivotal.io/s/article/OIDC-Response-Header-overflow) in the Knowledge Base.


#### One Plan ID Longer than Other Plan IDs

**Symptom**

One of your plan IDs is one character longer than your other plan IDs.

**Explanation**

In Enterprise PKS, each plan has a unique plan ID. A plan ID is normally a UUID consisting of 32 alphanumeric characters and 4 hyphens. However, the **Plan 4** ID consists of 33 alphanumeric characters and 4 hyphens.

**Solution**

You can safely configure and use **Plan 4**. The length of the **Plan 4** ID does not affect the functionality of **Plan 4** clusters.

If you require all plan IDs to have identical length, do not activate or use **Plan 4**.


#### NSX-T Pre-Check Errand Fails Due to Edge Node Configuration

**Symptom**

You have configured your NSX-T Edge Node VM as `medium` size, and the NSX-T Pre-Check Errand fails with the following error: “_ERROR: NSX-T Precheck failed due to Edge Node … no of cpu cores is less than 8_”.

**Explanation**

The NSX-T Pre-Check Errand is erroneously returning the “_cpu cores is less than 8_” error.

**Solution**

You can safely configure your NSX-T Edge Node VMs as `medium` size and ignore the error.


#### Metrics Server uses Weak Ciphers

The `metrics-server` component communicates over TLS v1.2 with weak ciphers. All other &lt;%= vars.product_short % components use TLS v1.2 with strong ciphers.

**Forward Looking Statement**

<span class="fwd-looking-stmt">
This contains statements relating to Pivotal’s expectations, projections, beliefs and prospects which are "forward-looking statements" within the meaning of the federal securities laws and by their nature are uncertain. Words such as "believe," "may," "will," "estimate," "continue," "anticipate," "intend," "expect," "plans," and similar expressions are intended to identify forward-looking statements. Such forward-looking statements are not guarantees of future performance, and you are cautioned not to place undue reliance on these forward-looking statements. Actual results could differ materially from those projected in the forward-looking statements as a result of many factors, including but not limited to: (i) our limited operating history as an independent company, which makes it difficult to evaluate our prospects; (ii) the substantial losses we have incurred and the risks of not being able to generate sufficient revenue to achieve and sustain profitability; (iii) our future success depending in large part on the growth of our target markets; (iv) our future growth depending largely on Pivotal Cloud Foundry and our platform-related services; (v) our subscription revenue growth rate not being indicative of our future performance or ability to grow; (vi) our business and prospects being harmed if our customers do not renew their subscriptions or expand their use of our platform; (vii) any failure by us to compete effectively; (viii) our long and unpredictable sales cycles that vary seasonally and which can cause significant variation in the number and size of transactions that can close in a particular quarter; (ix) our lack of control of and inability to predict the future course of open-source technologies, including those used in Pivotal Cloud Foundry; and (x) any security or privacy breaches. All information set forth in this release is current as of the date of this release. These forward-looking statements are based on current expectations and are subject to uncertainties, risks, assumptions, and changes in condition, significance, value and effect as well as other risks disclosed previously and from time to time in documents filed by us with the U.S. Securities and Exchange Commission (SEC), including our prospectus dated April 19, 2018, and filed pursuant to Rule 424(b) under the U.S. Securities Act of 1933, as amended. Additional information will be made available in our quarterly report on Form 10-Q and other future reports that we may file with the SEC, which could cause actual results to vary from expectations. We disclaim any obligation to, and do not currently intend to, update any such forward-looking statements, whether written or oral, that may be made from time to time except as required by law."
</span>
