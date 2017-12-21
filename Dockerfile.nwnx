# Declared here to be used by the FROM below
ARG NWN_VERSION
ARG NWN_TAG
ARG NWN_VERSION_SUFFIX

FROM i386/debian:stretch-slim as builder

# Declared here to be used inside the builder
ARG NWN_VERSION

RUN apt-get update

RUN apt-get -y install unzip
RUN mkdir -p /nwn/nwnx
ADD https://code.nwnx.io/nwnxee/unified/-/jobs/artifacts/build${NWN_VERSION}/download?job=build /nwn/nwnx/temp
RUN unzip -j /nwn/nwnx/temp -d /nwn/nwnx

RUN rm -r /var/cache/apt /var/lib/apt/lists

FROM ${NWN_TAG}:${NWN_VERSION}${NWN_VERSION_SUFFIX}
LABEL maintainer "niv@beamdog.com"

RUN apt-get update && \
  apt-get -y install libmariadbclient18:i386 ruby && \
  rm -r /var/cache/apt /var/lib/apt/lists

# Don't mirror logs to stdout, NWNX_ServerLogRedirector takes care of that.
ENV NWN_TAIL_LOGS=n

ENV NWNX_CORE_LOAD_PATH=/nwn/nwnx/
ENV NWN_LD_PRELOAD=/nwn/nwnx/NWNX_Core.so

# Copy the nwnx binaries from builder image
COPY --from=builder /nwn/nwnx/ /nwn/nwnx/

# Deploy run scripts
COPY /docker/run-nwnx-server.sh /nwn/
RUN chmod +x /nwn/run-nwnx-server.sh

# Plugins: The ones needed to make docker usage pleasant or safe are
# enabled by default:
ENV NWNX_CORE_SKIP=n \
    NWNX_SERVERLOGREDIRECTOR_SKIP=n

# The rest is only enabled on user request.
ENV NWNX_ADMINISTRATION_SKIP=y \
    NWNX_BEHAVIOURTREE_SKIP=y \
    NWNX_CHAT_SKIP=y \
    NWNX_CREATURE_SKIP=y \
    NWNX_DATA_SKIP=y \
    NWNX_EVENTS_SKIP=y \
    NWNX_METRICS_INFLUXDB_SKIP=y \
    NWNX_OBJECT_SKIP=y \
    NWNX_PLAYER_SKIP=y \
    NWNX_RUBY_SKIP=y \
    NWNX_SQL_SKIP=y \
    NWNX_THREADWATCHDOG_SKIP=y \
    NWNX_TRACKING_SKIP=y

ENTRYPOINT ["/nwn/run-nwnx-server.sh"]    
