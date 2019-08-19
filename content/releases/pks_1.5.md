
PKS 1.5 is scheduled for release in late August. With this release, we have a handful of changes to share with you:


## Features

New features and changes in this release:


*   Cluster administrators and managers can use the PKS CLI command `pks cluster CLUSTER-NAME --details` to view details about the named cluster, including Kubernetes nodes and NSX-T network details.
*   Cluster administrators can define a network profile to use a third-party load balancer for Kubernetes services of type LoadBalancer. 
*   Cluster administrators can define a network profile to use a third-party ingress controller for Pod ingress traffic.
*   Cluster administrators can define a network profile to configure section markers for explicit distributed firewall rule placement.
*   Cluster administrators can define a network profile to configure NCP logging
*   Cluster administrators can define a network profile to configure DNS lookup of the IP addresses for the Kubernetes API load balancer and the ingress controller.
*   Cluster administrators can provision a Windows worker-based Kubernetes cluster on vSphere with Flannel. Windows worker-based clusters in Enterprise PKS 1.5 currently do not support NSX-T integration. 
*   Operators can set the lifetime for the refresh and access tokens for Kubernetes clusters. You can configure the token lifetimes to meet your organization’s security and compliance needs. 
*   Operators can configure prefixes for OpenID Connect (OIDC) users and groups to avoid name conflicts with existing Kubernetes system users. Pivotal recommends adding prefixes to ensure OIDC users and groups do not gain unintended privileges on clusters.
*   Operators can configure an external SAML identity provider for user authentication and authorization. 
*   Operators can configure the Telgraf agent to send master/etcd node metrics to a third-party monitoring service.
*   Operators can configure the default node drain behavior. You can use this feature to resolve hanging or failed cluster upgrades. 
*   App developers can create metric sinks for namespaces within a Kubernetes cluster.
*   VMware’s Customer Experience Improvement Program (CEIP) and the Pivotal Telemetry Program (Telemetry) are now enabled in Enterprise PKS by default. This includes both new installations and upgrades.
*   Enterprise PKS adds VMware Enterprise PKS Management Console that provides a graphical interface for deploying Enterprise PKS on vSphere.

Breaking Changes \
Enterprise PKS v1.5.0 has the following breaking changes:


### New OIDC Prefixes Break Existing Cluster Role Bindings: \
In Enterprise PKS v1.5, operators can configure prefixes for OIDC usernames and groups. If you add OIDC prefixes you must manually change any existing role bindings that bind to a username or group. If you do not change your role bindings, developers cannot access Kubernetes clusters


### New API Group Name for Sink Resources:

The `apps.pivotal.io` API group name for sink resources is no longer supported. The new API group name is `pksapi.io`.

When creating a sink resource, your sink resource YAML definition must start with `apiVersion: pksapi.io/v1beta1`. All existing sinks are migrated automatically. \



### Log Sink Changes \
Enterprise PKS v1.5.0 adds the following log sink changes:



*   The `ClusterSink` log sink resource has been renamed to `ClusterLogSink` and the `Sink` log sink resource has been renamed to `LogSink`.
    *   When you create a log sink resource with YAML, you must use one of the new names in your sink resource YAML definition. For example, specify `kind: ClusterLogSink` to define a cluster log sink. All existing sinks are migrated automatically.
    *   When managing your log sink resources through kubectl, you must use the new log sink resource names. For example, if you want to delete a cluster log sink, run `kubectl delete clusterlogsink `instead of `kubectl delete clustersink`.
*   Log transport now requires a secure connection. When creating a `ClusterLogSink` or `LogSink`resource, you must include `enable_tls: true` in your sink resource YAML definition. All existing sinks are migrated automatically.


## Kubernetes versioning: \
PKS 1.5 is based on [Kubernetes 1.14.5](https://v1-14.docs.kubernetes.io) if you would to refer to those release notes as well.

**Forward Looking Statement.**

<span class="fwd-looking-stmt">
This contains statements relating to Pivotal’s expectations, projections, beliefs and prospects which are "forward-looking statements” within the meaning of the federal securities laws and by their nature are uncertain. Words such as "believe," "may," "will," "estimate," "continue," "anticipate," "intend," "expect," "plans," and similar expressions are intended to identify forward-looking statements. Such forward-looking statements are not guarantees of future performance, and you are cautioned not to place undue reliance on these forward-looking statements. Actual results could differ materially from those projected in the forward-looking statements as a result of many factors, including but not limited to: (i) our limited operating history as an independent company, which makes it difficult to evaluate our prospects; (ii) the substantial losses we have incurred and the risks of not being able to generate sufficient revenue to achieve and sustain profitability; (iii) our future success depending in large part on the growth of our target markets; (iv) our future growth depending largely on Pivotal Cloud Foundry and our platform-related services; (v) our subscription revenue growth rate not being indicative of our future performance or ability to grow; (vi) our business and prospects being harmed if our customers do not renew their subscriptions or expand their use of our platform; (vii) any failure by us to compete effectively; (viii) our long and unpredictable sales cycles that vary seasonally and which can cause significant variation in the number and size of transactions that can close in a particular quarter; (ix) our lack of control of and inability to predict the future course of open-source technologies, including those used in Pivotal Cloud Foundry; and (x) any security or privacy breaches. All information set forth in this release is current as of the date of this release. These forward-looking statements are based on current expectations and are subject to uncertainties, risks, assumptions, and changes in condition, significance, value and effect as well as other risks disclosed previously and from time to time in documents filed by us with the U.S. Securities and Exchange Commission (SEC), including our prospectus dated April 19, 2018, and filed pursuant to Rule 424(b) under the U.S. Securities Act of 1933, as amended. Additional information will be made available in our quarterly report on Form 10-Q and other future reports that we may file with the SEC, which could cause actual results to vary from expectations. We disclaim any obligation to, and do not currently intend to, update any such forward-looking statements, whether written or oral, that may be made from time to time except as required by law.”
</span>

<!-- Docs to Markdown version 1.0β17 -->
