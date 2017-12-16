FROM beamdog/nwserver:8152
LABEL maintainer "niv@beamdog.com"


RUN apt-get update

# This is needed so openjdk installs properly.
RUN mkdir -p mkdir -p /usr/share/man/man1
RUN apt-get -y install libmariadbclient18:i386

RUN apt-get -y install unzip
RUN mkdir -p /nwn/nwnx
ADD https://code.nwnx.io/nwnxee/unified/-/jobs/artifacts/build8152/download?job=build /nwn/nwnx/temp
RUN unzip -j /nwn/nwnx/temp -d /nwn/nwnx
RUN rm /nwn/nwnx/temp
RUN apt-get -y purge unzip

RUN rm -r /var/cache/apt /var/lib/apt/lists


# Don't mirror logs to stdout, NWNX_ServerLogRedirector takes care of that.
ENV NWN_TAIL_LOGS=n

ENV NWNX_CORE_LOAD_PATH=/nwn/nwnx/
ENV NWN_LD_PRELOAD=/nwn/nwnx/NWNX_Core.so

ENV NWNX_CORE_SKIP=n

# Plugins: The ones needed to make docker usage pleasant or safe are
# enabled by default:
ENV NWNX_SERVERLOGREDIRECTOR_SKIP=n

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
    NWNX_SQL_SKIP=y \
    NWNX_THREADWATCHDOG_SKIP=y \
    NWNX_TRACKING_SKIP=y
