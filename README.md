# meta-rpcme-iot-distro



DISTRO=rpcme-iot-riscv MACHINE=freedom-u540 bitbake riscv-iot-distro


xzcat
tmp-glibc/deploy/images/freedom-u540/riscv-iot-distro-freedom-u540.wic.xz
| sudo dd of=/dev/sda bs=512K iflag=fullblock oflag=direct conv=fsync status=progress
