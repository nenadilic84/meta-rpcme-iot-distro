SUMMARY = "Example artifacts for AWS IoT Device Client - Fleet Provisioning"
DESCRIPTION = ""
#LICENSE = "CC-BY-ND-4.0"
#LIC_FILES_CHKSUM = "file://legalcode.txt;md5=e9b16dfa2ccd8322021dac7adbaf249f"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""
SRC_URI = "https://www.amazontrust.com/repository/AmazonRootCA2.pem"

SRC_URI[sha256sum] = "a3a7fe25439d9a9b50f60af43684444d798a4c869305bf615881e5c84a44c1a2"
do_configure() {
  touch ${S}/key.pem
  touch ${S}/cert.pem
}

do_install() {
  install -m 0700 -d ${D}${sysconfdir}/aws-iot-device-client/private
  install -m 0644 ${WORKDIR}/AmazonRootCA2.pem ${D}${sysconfdir}/aws-iot-device-client/private/root-ca.pem
  install -m 0644 ${S}/cert.pem ${D}${sysconfdir}/aws-iot-device-client/private/cert.pem
  install -m 0600 ${S}/key.pem ${D}${sysconfdir}/aws-iot-device-client/private/key.pem
}

RDEPENDS:${PN} = "aws-iot-device-client"
