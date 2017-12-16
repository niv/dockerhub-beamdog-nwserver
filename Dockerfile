FROM i386/debian:stretch-slim
LABEL maintainer "niv@beamdog.com"

RUN apt-get update && \
  apt-get --no-install-recommends -y install \
    libc6:i386 libstdc++6:i386 && \
  rm -r /var/cache/apt /var/lib/apt/lists

# Data layout:
# /nwn/data (/data/*.key) = distro data, minimized
# /nwn/home               = readonly mounted from outside
# /nwn/run                = runtime directory

RUN mkdir -p /nwn/data
RUN mkdir -p /nwn/home
RUN mkdir -p /nwn/run

# Copy them in separate layers so we can store the big bad data
# layer more efficiently.
COPY /data/data /nwn/data/data

ENV NWN_ARCH linux-x86

COPY /data/bin/${NWN_ARCH} /nwn/data/bin/${NWN_ARCH}
RUN chmod +x /nwn/data/bin/${NWN_ARCH}/nwserver-linux

COPY /run-server.sh /prep-nwn-ini.awk /prep-nwnplayer-ini.awk /nwn/
RUN chmod +x /nwn/run-server.sh

# /nwn/home: This should be mounted by the user.
VOLUME /nwn/home

EXPOSE ${NWN_PORT:-5121}/udp

ENV NWN_TAIL_LOGS=y
ENV NWN_EXTRA_ARGS="-userdirectory /nwn/run"

WORKDIR /nwn/data/bin/${NWN_ARCH}
ENTRYPOINT ["/bin/bash", "/nwn/run-server.sh"]
