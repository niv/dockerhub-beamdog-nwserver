#!/bin/bash

set -e

ROHOMEPATH=/nwn/home
HOMEPATH=/nwn/run

# Setup custom nwnx plugin folder 
if [ "$NWNX_ENABLED" = "y" ]; then
  if [ -d $ROHOMEPATH/nwnx ]; then
    if [ -e $ROHOMEPATH/nwnx/*.so ]; then 
      echo "[*] Copying custom plugin(s) to nwnx folder"
      cp -v $ROHOMEPATH/nwnx/*.so /nwn/nwnx
    fi
  fi
fi

/nwn/run-server.sh