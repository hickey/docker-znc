# znc
#
# VERSION               1.2.0
# DOCKER-VERSION        0.6.1

FROM       ubuntu:12.04
MAINTAINER Gerard Hickey <hickey@kinetic-compute.com>

VOLUME ["/znc-data"]
ENV ZNCDATA /znc-data

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise-backports universe" >> /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y znc/precise-backports znc-dbg/precise-backports znc-dev/precise-backports znc-extra/precise-backports znc-perl/precise-backports znc-python/precise-backports znc-tcl/precise-backports && apt-get clean

RUN useradd znc
ADD . /src
RUN chown -R znc /znc-data
RUN cp /src/startup-znc /usr/local/bin


USER znc
EXPOSE 6660

WORKDIR /znc-data
CMD /usr/local/bin/startup-znc

