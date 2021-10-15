#! /bin/sh
curl https://storage.googleapis.com/git-repo-downloads/repo > /tmp/repo
chmod +x /tmp/repo
mkdir -p $HOME/rpcme-iot-riscv-distro/layers
cd $HOME/rpcme-iot-riscv-distro/layers
/tmp/repo init \
          -u https://github.com/rpcme/meta-rpcme-iot-distro \
          -m conf/distro/rpcme-iot-riscv.xml

/tmp/repo sync

cd $HOME/rpcme-iot-riscv-distro

echo next steps:
echo cd $HOME/rpcme-iot-riscv-distro
echo . layers/openembedded-core/oe-init-build-env
echo DISTRO=rpcme-iot-riscv \\
echo MACHINE=freedom-u540   \\
echo bitbake riscv-iot-distro
