FROM ubuntu:18.04

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -qq -y vim htop net-tools psmisc git wget curl python2.7-dev \
    python-ldap python-mysqldb zlib1g-dev libmemcached-dev gcc tzdata && \
    curl -sSL -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    python /tmp/get-pip.py && \
    rm -rf /tmp/get-pip.py && \
    pip install -U wheel

ADD requirements.txt  /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

WORKDIR /opt/seafile

ENV SEAFILE_VERSION=7.0.4 SEAFILE_SERVER=seafile-server

RUN mkdir -p /opt/seafile/ && \
    curl -sSL -o - https://download.seadrive.org/seafile-server_${SEAFILE_VERSION}_x86-64.tar.gz \
    | tar xzf - -C /opt/seafile/

# todo: replace bash with sh in scripts
COPY scripts /scripts

ENTRYPOINT ["bash", "/scripts/start.sh"]