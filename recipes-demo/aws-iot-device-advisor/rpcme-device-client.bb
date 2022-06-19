SUMMARY = "Example artifacts for AWS IoT Device Client - Fleet Provisioning"
DESCRIPTION = ""
#LICENSE = "CC-BY-ND-4.0"
#LIC_FILES_CHKSUM = "file://legalcode.txt;md5=e9b16dfa2ccd8322021dac7adbaf249f"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""
SRC_URI = "https://www.amazontrust.com/repository/AmazonRootCA1.pem \
           file://aws-iot-device-client.conf \
           file://key.pem \
           file://cert.pem \
"

SRC_URI[sha256sum] = "2c43952ee9e000ff2acc4e2ed0897c0a72ad5fa72c3d934e81741cbd54f05bd1"
do_configure() {
  sed -i -e "s,replace_with_endpoint_value,${DEMO_IOT_ENDPOINT}," ${WORKDIR}/aws-iot-device-client.conf
  sed -i -e "s,replace_with_thing_name_value,${DEMO_THING_NAME}," ${WORKDIR}/aws-iot-device-client.conf
  
}

do_install() {
  install -m 0745 -d ${D}${sysconfdir}/aws-iot-device-client
  install -m 0700 -d ${D}${sysconfdir}/aws-iot-device-client/private
  install -m 0700 -d ${D}${sysconfdir}/aws-iot-device-client/job-handlers
  install -m 0644 ${WORKDIR}/AmazonRootCA1.pem ${D}${sysconfdir}/aws-iot-device-client/private/root-ca.pem
  install -m 0644 ${WORKDIR}/cert.pem ${D}${sysconfdir}/aws-iot-device-client/private/cert.pem
  install -m 0600 ${WORKDIR}/key.pem ${D}${sysconfdir}/aws-iot-device-client/private/key.pem
  install -m 0644 ${WORKDIR}/aws-iot-device-client.conf ${D}${sysconfdir}/aws-iot-device-client/aws-iot-device-client.conf
}

RDEPENDS:${PN} = "aws-iot-device-client"
