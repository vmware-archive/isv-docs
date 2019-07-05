# Tile Generator FAQ

[Tile Generator Docs](https://docs.pivotal.io/tiledev)

## Migrations Output for Tile Upgrade

[Upgrading Tiles](https://docs.pivotal.io/tiledev/tile-upgrades.html)

Defining a migration for your tile and where to look for the output from the `migration` block in the tile.yml

Example

```
migration: |
  console.log("#### example of migration print console.log")
```

SSH into OpsMan Director

You can view the file `/var/log/opsmanger/production.log`

```
I, [2019-06-13T11:30:48.924963 #866]  INFO -- : Valid UAA token
I, [2019-06-13T11:30:49.436807 #866]  INFO -- : BEGIN: Javascript Product Data Migration /var/tempest/workspaces/default/product_data_migrations/tomcat-bosh-tile/0.0.57/201906130720_noop.js output
I, [2019-06-13T11:30:49.436914 #866]  INFO -- : #### example of migration print console.log
```
