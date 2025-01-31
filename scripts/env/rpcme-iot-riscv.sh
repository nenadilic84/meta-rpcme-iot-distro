#! /bin/sh
curl https://storage.googleapis.com/git-repo-downloads/repo > /tmp/repo
chmod +x /tmp/repo
mkdir -p $HOME/rpcme-iot-riscv-distro/layers
cd $HOME/rpcme-iot-riscv-distro/layers
/tmp/repo init \
          -u https://github.com/nenadilic84/meta-rpcme-iot-distro \
          -m conf/distro/rpcme-iot-riscv.xml

/tmp/repo sync

cd $HOME/rpcme-iot-riscv-distro

cd $HOME/rpcme-iot-riscv-distro
. layers/openembedded-core/oe-init-build-env

bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/layers/meta-openembedded/meta-oe
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/layers/meta-openembedded/meta-python
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/layers/meta-openembedded/meta-filesystems
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/layers/meta-openembedded/meta-networking
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/layers/meta-riscv
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/layers/meta-sifive
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/layers/meta-clang
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/layers/meta-swupdate
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/layers/meta-aws
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/layers/meta-rpcme-iot-distro

echo "NEXT STEP:"
echo "$ DISTRO=rpcme-iot-riscv MACHINE=freedom-u540 bitbake riscv-iot-distro"
