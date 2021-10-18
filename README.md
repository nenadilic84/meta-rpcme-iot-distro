## meta-rpcme-iot-distro

**meta-rpcme-iot-distro** is a set of distributions that I maintain
for IoT use case demonstrations on Embedded Linux. The distributions
are built with OpenEmbedded and bitbake. Usually, but not always, the
build system leans on Poky or Automotive Grade Linux for a more well
rounded baseline.

### riscv-iot-distro

**riskv-iot-distro** is an AWS IoT Device Client demonstration running
on the freedom-u540 (Unleashed) board.  Yes, I know this board is
deprecated, but it is still incredibly useful given it is a strong set
of cores that runs Linux effectively.

**KNOW THIS BEFORE YOU DO ANYTHING**

Setup the cloud-side prior to building and running the image. The
demonstration will fail without cloud-side provisioning.


#### Cloud configuration

Setup fleet provisioning to prepare for device first boot provisioning.

1. 

#### Device image

aws --profile work --region us-east-1 iot describe-endpoint

set in local.conf

`DEMO_IOT_ENDPOINT = "audqth7zumq6e.iot.us-east-1.amazonaws.com"`


Initialize the environment.

```bash
curl
https://raw.githubusercontent.com/rpcme/meta-rpcme-iot-distro/main/scripts/env/rpcme-iot-riscv.sh | \
  bash
```

Initialize the environment.

```bash
cd $HOME/rpcme-iot-riscv-distro
. ./layers/openembedded-core/oe-init-build-env
DISTRO=rpcme-iot-riscv MACHINE=freedom-u540 bitbake riscv-iot-distro
```

Write the image to flash.

```bash
wic=$BBPATH/tmp-glibc/deploy/images/freedom-u540/riscv-iot-distro-freedom-u540.wic.xz

xzcat ${wic} | sudo dd of=/dev/sda \
                       bs=512K iflag=fullblock oflag=direct \
                       conv=fsync status=progress
```
