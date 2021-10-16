#+ /bin/sh

if test $# != 1; then
    echo You need to pass in the role arn for the role having the AWSIoTThingsRegistration managed policy attached.
fi

aws iot create-provisioning-template \
    --template-name fp-template-claim \
    --description "Provision by claim with no parameters" \
    --template-body file://$0/fp-template-claim.json \
    --enabled \
    --provisioning-role-arn $1

aws iot create-provisioning-claim \
    --template-name fp-template-claim \
    > fp-template-claim.out.json

jq .keyPair.PrivateKey out.json | xargs echo -e > fp-template-claim.key.pem
jq .certificatePem.PrivateKey out.json | xargs echo -e > fp-template-claim.key.pem

