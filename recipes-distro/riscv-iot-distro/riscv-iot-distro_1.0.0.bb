SUMMARY = "My RISC-V IoT Demo"
DESCRIPTION = "Recipe created by bitbake-layers, modified for "
LICENSE = "MIT"

python do_display_banner() {
    bb.plain("***********************************************");
    bb.plain("*                                             *");
    bb.plain("*  Example recipe created by bitbake-layers   *");
    bb.plain("*  * Turned into a distro recipe for fun  *   *");
    bb.plain("*                                             *");
    bb.plain("***********************************************");
}

addtask display_banner before do_build

inherit core-image extrausers

EXTRA_USERS_PARAMS = "usermod -p '\$6\$PWVNV6MfuO4pMdqO\$54BibXcgV/nXMrgbaMBioGHNDv1uGVFarQN9QnqM8IMOI/nEwnpB5noxJozigw0lObahcmc3lqTMPvLoSpXnP1' root;"

IMAGE_FEATURES += " splash ssh-server-openssh"

IMAGE_INSTALL = "\
    packagegroup-core-boot \
    packagegroup-core-full-cmdline \
    chrony \
    i2c-tools \
    i2c-tools-misc \
    networkmanager \
    networkmanager-nmcli \
    spitools \
    jq \
    perl-module-locale \
    perl-modules \
    strace \
    rpcme-device-client \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    "

IMAGE_INSTALL:append:freedom-u540 = "\
    unleashed-udev-rules \
    "

IMAGE_INSTALL:append:unmatched = " \
    unmatched-udev-rules \
    unmatched-systemd-units \
    "

