# Pivotal Platform 2.9

## Notice for Partners with Nozzles

The v1 nozzle endpoint is deprecated in 2.9 and will be off by default. v1 nozzles will 
continue to work in this release with operator intervention. However, in 2.10, v1 nozzles 
will stop working completely.

You may already be using the v2 API, we’re communicating this broadly to ensure that no partners are missed.

The open source Loggregator repository has 
[an RLP client](https://github.com/cloudfoundry/go-loggregator/blob/master/rlp_gateway_client.go)
that can be used as the base of a production v2 nozzle.  

Our team has also built v2 API examples in the GitHub
repository [firehose-nozzle-v2](https://github.com/cf-platform-eng/firehose-nozzle-v2). This is
a minimal example of how to establish that connection; the RLP client is a better base for a production system.
This repository does uniquely include how to package the Nozzle as a Tile. There are two 
ways of connecting: the Reverse Log Proxy (RLP) and the Reverse Log Proxy Gateway (RLP Gateway). We 
recommend using the Gateway, as the deployment and authentication model is simpler (a BOSH release 
isn’t required and the nozzle can be deployed as an app when using the RLP Gateway).

Reverse Log Proxy Gateway support was added in PAS 2.4.  Pivotal support policies (n-2 release) 
should allow this support to be widespread by the September release of PAS 2.7.

The payload will be slightly different, so translation into your system of record will require code changes. 
The [loggregator API documentation describes](https://github.com/cloudfoundry/loggregator-api/blob/master/README.md#v2---v1-mapping) 
a mapping between the v1 and v2 payload.

If you’re unsure what version of the API you’re consuming, check the Golang dependencies. 
Using noaa and sonde-go indicates is the v1 API. The v2 API uses either go-loggregator or, 
for a Gateway based solution, potentially no Cloud Foundry specific libraries.

The [firehose-to-syslog project](https://github.com/cloudfoundry-community/firehose-to-syslog) is a more complex, 
real-world example that was migrated from v1 to v2 via [this pull request](https://github.com/cloudfoundry-community/firehose-to-syslog/pull/213).

Migrating to v2 does carry additional advantages:

* V2 moves away from WebSockets for communication, which caused issues with load balancers.
* V2 adds the ability to filter messages at source, which can greatly reduce the amount of data ingested. The model is no longer accept everything and discard.
* V2 reduces messages loss.

Additional resources to help with this transition:

* The [mailing list thread](https://lists.cloudfoundry.org/g/cf-dev/topic/proposal_deprecation_of_the/29741830?p=,,,20,0,0,0::recentpostdate%2Fsticky,,,20,2,0,29741830) proposing and discussing the deprecation
* The [RLP Gateway docs](https://github.com/cloudfoundry/loggregator/blob/master/docs/rlp_gateway.md)
* The [README for cf-platform-eng/firehose-nozzle-v2](https://github.com/cf-platform-eng/firehose-nozzle-v2/blob/master/README.md) contains additional reference material and details.
