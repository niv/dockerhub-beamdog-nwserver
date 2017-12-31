#!/bin/bash

usage() { echo "$0 usage:" && grep " .)\ #" $0; exit 0; }

DOCKERFILE=Dockerfile.nwnx

while getopts ":hlt:v:r:s:" o; do
    case "${o}" in
        l) # Build image using local nwnx binaries in local Binaries folder
            DOCKERFILE=Dockerfile.nwnx.local
            ;;
        r) # Base Image Repository - eg glorwinger/nwserver
            REPOSITORY=${OPTARG}
            ;;
        t) # Image Tag - eg glorwinger/nwserver:8152.nwnx
            TAG=${OPTARG}
            ;;
        s) # Base Image Suffix - Will be appended to the version to identify the base image - eg .1
            SUFFIX=${OPTARG}
            ;;
        v) # Headstart Build Number - eg 8152
            VERSION=${OPTARG}
            ;;
        h | *) # Display help
            usage
            exit 0
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${TAG}" ] || [ -z "${VERSION}" ] || [ -z "${REPOSITORY}" ] || [ -z "${SUFFIX}" ]; then
    usage
fi

docker build -t ${TAG} --build-arg NWN_VERSION=${VERSION} --build-arg NWN_TAG=${REPOSITORY} --build-arg NWN_VERSION_SUFFIX=${SUFFIX} . -f ${DOCKERFILE}