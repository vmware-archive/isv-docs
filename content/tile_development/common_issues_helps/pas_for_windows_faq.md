# PAS for Windows FAQ

## Installation

Installing **PAS for Windows** requires significantly more resources than BOSH is granted by default. To provide adequate resoruces:

1. Login to **Ops Manager** .
2. Click the **Bosh Director for GCP** tile.
3. Scroll down to **Resource Config**.  
4. Increase **Master Compilation Job** to `xlarge.disk( cpu: 4, ram: 16 GB, disk: 128 GB)`.
