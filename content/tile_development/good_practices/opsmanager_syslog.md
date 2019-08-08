# Ops Manager Syslog Form

This topic describes enabling the Ops Manager Syslog Form for Service Tiles.

## Overview

PCF Customers expect to be able to extract logging data from the platform and the services running on top of it. It is often an audit requirement to extract and store this information. The Ops Manager Syslog form allows a simple way for tile authors to include a form that operators can use to configure syslog forwarding.

## Who is this for?

* [Managed Service Tiles](https://docs.pivotal.io/tiledev/managed.html)
* Eventually [On-Demand Service Tiles](https://docs.pivotal.io/tiledev/on-demand.html) however not as of PCF v2.6

## Requirements

PCF v2.5+ for Managed Service Tiles

## Implementation

For tiles with no syslog configuration implementation then it is as simple as adding `opsmanager_syslog: true` to your tile config, see [Property and Template References](https://docs.pivotal.io/tiledev/property-template-references.html#syslog-flag).

If you currently have a syslog form in your tile then you will need to migrate to the Ops Manager provided form, see [Migrating Existing Syslog Configuration to Ops Manager](https://docs.pivotal.io/tiledev/migrating-syslog-configuration.html).
