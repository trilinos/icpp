#!/bin/bash --login

#podman login --tls-verify=false --username ${CI_REGISTRY_USER} --password ${CI_JOB_TOKEN} ${CI_REGISTRY}

PODMAN_ARGS=()

if [ -d /host-etc ] ; then
    ETC="/host-etc"
else
    ETC="/etc"
fi

##################################################
# Map certificates from host into container
if [ -f ${ETC}/ssl/certs/ca-bundle.crt ] ; then
    PODMAN_ARGS+=("-v${ETC}/ssl/certs/ca-bundle.crt:/certs/certs.crt:ro")
elif [ -f ${ETC}/ssl/certs/ca-certificates.crt ] ; then
    PODMAN_ARGS+=("-v${ETC}/ssl/certs/ca-certificates.crt:/certs/certs.crt:ro")
fi


PODMAN_ARGS+=(
    "--env" "SSL_CERT_FILE=/certs/certs.crt"
    "--env" "PIP_CERT=/certs/certs.crt"
    "--env" "CURL_CA_BUNDLE=/certs/certs.crt"
    "--env" "REQUESTS_CA_BUNDLE=/certs/certs.crt"
    "--unsetenv" "SSL_CERT_FILE"
    "--unsetenv" "PIP_CERT"
    "--unsetenv" "CURL_CA_BUNDLE"
    "--unsetenv" "REQUESTS_CA_BUNDLE"

    "--tls-verify=false"
    "--pull=newer"
    "--network=host"
)

if [ ! -z "${EXTRA_PODMAN_ARGS}" ] ; then
    PODMAN_ARGS+=("${EXTRA_PODMAN_ARGS}")
fi

podman build "${PODMAN_ARGS[@]}" -t ${NEW_IMAGE} --format=Docker -f ${DOCKERFILE}

# podman build --tls-verify=false --pull=newer --network host \
#        -v /host-etc/ssl:/etc/ssl \
#        -v /host-etc/pki/tls:/etc/pki/tls \
#        -v /host-etc/pki/ca-trust:/etc/pki/ca-trust \
#        -t ${NEW_IMAGE} --format=Docker ${DOCKERFILE_DIRECTORY}

# podman push --tls-verify=false ${NEW_IMAGE}
