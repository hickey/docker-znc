# znc
#
# VERSION               1.0.2
# DOCKER-VERSION        0.6.1

FROM       ubuntu:12.04
MAINTAINER Gerard Hickey <hickey@kinetic-compute.com>

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise-backports universe" >> /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y znc/precise-backports znc-dbg/precise-backports znc-dev/precise-backports znc-extra/precise-backports znc-perl/precise-backports znc-python/precise-backports znc-tcl/precise-backports && apt-get clean

RUN useradd znc
ADD . /src
RUN mkdir -p /znc-data/configs && chown -R znc /znc-data
RUN cp /src/znc-init.conf /etc/init/znc.conf


USER znc
EXPOSE 6660

VOLUME ["/znc-data"]
ENV ZNCDATA /znc-data

WORKDIR /znc-data
CMD start znc

