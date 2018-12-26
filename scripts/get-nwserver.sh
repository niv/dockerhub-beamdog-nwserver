#!/bin/bash


if [ "$1" == "" ]; then
    echo "Provide the Headstart Build Number - eg 8152"
    exit 1
fi

if [ ! -d nwserver ]; then
    mkdir nwserver
fi

pushd nwserver

if [ ! -e nwnee-dedicated-$1.zip ]; then
    wget https://nwnx.io/nwnee-dedicated-$1.zip 
fi

if [ ! -d nwnee-dedicated-$1 ]; then
    unzip -d nwnee-dedicated-$1 nwnee-dedicated-$1.zip 
fi

rm nwnee-dedicated

ln -vs nwnee-dedicated-$1 nwnee-dedicated

popd