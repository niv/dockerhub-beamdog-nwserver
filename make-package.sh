#!/bin/bash
set -e

if [ "$TAG" = "" ]; then
  echo "env var TAG not specified"
  exit 1
fi

echo "Using tag: $TAG. Enter for OK, ^C to cancel. [Make sure to git branch if not correct]"
read

if [ ! -f "$NWN_ROOT/data/nwn_base.key" ]; then
  echo "NWN_ROOT not specified"
  exit 1
fi

set -x
mkdir -p data/bin/linux-x86/
cp -va "$NWN_ROOT"/bin/linux-x86/nwserver-linux data/bin/linux-x86/
mkdir -p data/data/ data/lang/en/data
cp -va "$NWN_ROOT"/lang/en/data/dialog.tlk data/lang/en/data/
cp -va "$NWN_ROOT"/data/cacert.pem data/data/
nwn_resman_pkg --verbose -d data/data --root "$NWN_ROOT"

docker build --pull --no-cache -f Dockerfile --build-arg IMAGE=debian:buster-slim -t beamdog/nwserver:$TAG-debian-buster -t beamdog/nwserver:$TAG -t beamdog/nwserver:latest .
docker build --pull --no-cache -f Dockerfile --build-arg IMAGE=ubuntu:focal -t beamdog/nwserver:$TAG-ubuntu-focal .

set +x

echo ""
echo "All done, now verify the images and then run to push:"
echo " beamdog/nwserver:latest"
echo " docker push beamdog/nwserver:$TAG"
echo " docker push beamdog/nwserver:$TAG-debian-buster"
echo " docker push beamdog/nwserver:$TAG-ubuntu-focal"
echo ""
echo "Don't forget to update the master branch."
