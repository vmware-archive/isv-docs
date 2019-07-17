# Secure Bindings in On-Demand Broker

This topic describes enabling the Secure Bindings feature for On-Demand Service Tiles.

## Overview

By default the ODB stores service bindings and service keys in plain text, it also passes plain text bindings over the network to the bound app. In order to reduce credential leakiness ODB can be configured to enable secure bindings. With secure bindings enabled service binding and service key credentials are stored in the runtime (PAS) CredHub and the CredHub references are passed over the network instead of plain text credentials.

## Who is this for?

[On-Demand Service Tiles](https://docs.pivotal.io/tiledev/on-demand.html)

## Requirements

* [On-Demand Service Broker](https://network.pivotal.io/products/on-demand-services-sdk/) v0.18.0+
* PCF v2.0+

## Implementation

For implementation details, including example code, see [Allow Secure Binding](https://docs.pivotal.io/svc-sdk/odb/tile.html#secure-creds) in the On-Demand Services SDK docs.
