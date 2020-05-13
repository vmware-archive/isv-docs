# PAS for Windows

## General Documentation

[Pivotal Application Service for Windows](https://docs.pivotal.io/pivotalcf/current/windows/index.html)

## Tips and Tricks

### Install without slow downloads and uploads

Installing PAS for Windows requires downloading and uploading several GB of files so it often is faster to execute the process directly on the Ops Manager VM.

> Note: If you have fast internet, feel free to follow [Installing and Configuring PASW](https://docs.pivotal.io/platform/application-service-windows/2-9/installing.html)

1. SSH into the Ops Manager using [hammer cli](https://github.com/pivotal/hammer)
   - `hammer -t <my-env>.hammer.json ssh opsman`
2. Install [om cli](https://github.com/pivotal-cf/om/releases)
   1. `wget https://github.com/pivotal-cf/om/releases/download/<version>/om-linux-<version>`
   2. `mv om-linux-<version> om`
   3. `chmod +x om`
   4. To ensure it works execute: `./om --version`
3. Install the [pivnet cli](https://github.com/pivotal-cf/pivnet-cli/releases)
   - Use the same process as used for the `om` cli.
4. Login to Pivotal Network
   1. Login and get a _UAA API TOKEN_ in [Edit Profile](https://network.pivotal.io/users/dashboard/edit-profile) for use in the cli
   2. `./pivnet login --api-token <uaa api token>`
5. Find **PAS for Windows**
   1. `./pivnet ps | grep -i win`
   2. `./pivnet rs -p pas-windows`
   3. `./pivnet pfs -p pas-windows -r 2.6.1`
6. Download both **PAS for Windows** and **Windows FS Injector** using:
   - `./pivnet dlpf -p <slug> -r <release> -i <product-file-id>`
7. Build and [Install the tile](https://docs.pivotal.io/platform/application-service-windows/2-9/installing.html)
   1. `unzip winfs-injector-<version>.zip`
   2. `chmod +x winfs-injector-linux`
   3. `./winfs-injector-linux --input-tile pas-windows-<version>-build.<build>.pivotal --output-tile PAS-WINDOWS-INJECTED.pivotal`
       - Note: The build will take some time
   4. Upload the tile to Ops Manager
       - `./om -k -t https://pcf.<opsman-env>.cf-app.com/ -u pivotalcf -p <password> upload-product -p PAS-WINDOWS-INJECTED.pivotal`
       - Note: Ops Manger verify the file before responding
   5. Login to the Ops Manager web application and import _Pivotal Application Service for Windows_ by clicking the **+** button.
8. Ensure the BOSH Master Compilation Job has enough resources, as described above.
9. Continue on with [Step 3: Configure the Tile](https://docs.pivotal.io/platform/application-service-windows/2-9/installing.html#config)
   1. At [Step 5: Upload a Stemcell](https://docs.pivotal.io/platform/application-service-windows/2-9/installing.html#stemcells) go to [Pivotal Network: Stemcells for PCF (Windows)](https://network.pivotal.io/products/stemcells-windows-server) and download the light stemcell required.
       - For most shared partner environments the **GCP light Stemcell**

## Troubleshooting

### Issue: Install fails with 'Write failed tar: Error...'

**PAS for Windows** requires more resources than BOSH is granted by default. To provide adequate resources:

1. Login to **Ops Manager** .
2. Click the **Bosh Director for GCP** tile.
3. Scroll down to **Resource Config**.  
4. Verify that **Master Compilation Job** to `xlarge.disk( cpu: 4, ram: 16 GB, disk: 128 GB)`.

#### Sample error

```bash
Task 435 | 17:27:58 | Error: Action Failed get_task: Task 
...
Running command: 'tar --no-same-owner -xzf C:\var\vcap\data\tmp\bosh-blobstore-externalBlobstore-Get558405054 -C \var\vcap\data\compile/windows2019fs-bosh-agent-unpack'
, stdout: ''
, stderr: './windows2019fs/windows2016fs-2019.0.15.tgz: 
Write failed tar: Error exit delayed from previous errors.'
```
