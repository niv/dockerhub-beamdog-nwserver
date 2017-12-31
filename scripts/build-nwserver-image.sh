#!/bin/bash

usage() { echo "$0 usage:" && grep " .)\ #" $0; exit 0; }

while getopts ":ht:v:" o; do
    case "${o}" in
        t) # Image Tag - eg glorwinger/nwserver:8152
            TAG=${OPTARG}
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

if [ -z "${TAG}" ] || [ -z "${VERSION}" ]; then
    usage
fi

docker build -t ${TAG} --build-arg NWN_VERSION=${VERSION} . -f Dockerfile.nwserver