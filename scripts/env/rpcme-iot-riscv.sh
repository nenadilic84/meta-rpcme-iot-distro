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

cd $HOME/rpcme-iot-riscv-distro
. layers/openembedded-core/oe-init-build-env

bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/meta-openembedded/meta-oe
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/meta-openembedded/meta-python
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/meta-openembedded/meta-filesystems
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/meta-openembedded/meta-networking
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/meta-riscv
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/meta-sifive
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/meta-clang
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/meta-swupdate
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/meta-aws
bitbake-layers add-layer $HOME/rpcme-iot-riscv-distro/meta-rpcme-iot-distro

printf "NEXT STEP:\n"
printf "$ DISTRO=rpcme-iot-riscv   \\\n"
printf "  MACHINE=freedom-u540     \\\n"
printf "  bitbake riscv-iot-distro\n"
