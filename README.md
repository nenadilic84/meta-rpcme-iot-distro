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

- Setup the cloud-side prior to building and running the image. The
demonstration will fail without cloud-side provisioning.
- It is expected that you have AWS CLI installed and configured for
  the target region where you want to operate.

#### Cloud configuration

Setup fleet provisioning to prepare for device first boot provisioning.

Please look at the scripts to understand the options.  The usage of
the script in step 3 is a bit rough at this point.

1. Create a fleet provisioning role as defined here. You will need
   this role ARN for step 3.
   1. Navigate to
      https://docs.aws.amazon.com/iot/latest/developerguide/provision-wo-cert.html
   2. Create role as defined in step 4, in section **Provisioning by
      claim**.  I hope to have a script to do this for you soon.
2. Generate credentials with `scripts/create-credential.sh` using the
   policy at `scripts/fleet-provisioning/fp-policy.json`.
3. Create the fleet provisioning template using the script
   `scripts/fleet-provisioning/setup.sh`.

#### Device image


Initialize the environment.

```bash
curl
https://raw.githubusercontent.com/rpcme/meta-rpcme-iot-distro/main/scripts/env/rpcme-iot-riscv.sh | \
  bash
```

Set in local.conf

```text
DEMO_IOT_ENDPOINT = "<ENDPOINT>"`
```

Where `<ENDPOINT>` is the value output from the following:


```bash
aws --output text --query endpointAddress iot describe-endpoint --endpoint-type iot:data-ats
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
