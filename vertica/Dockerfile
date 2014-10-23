FROM centos:centos6
MAINTAINER Jakub Jedelsky <jakub.jedelsky@gooddata.com>

# update system & install dependencies
RUN yum -q -y update
RUN yum -q -y install mcelog sudo openssh-clients which openssl

# set env variables
ENV LANG en_US.utf8
ENV TZ UTC
ENV DBUSER vertica
ENV DBNAME verticadb

# data dir
ENV VERTICADATA /data
RUN mkdir $VERTICADATA
VOLUME ["$VERTICADATA"]

# add user and group
RUN useradd --system --create-home --user-group $DBUSER
RUN chown $DBUSER:$DBUSER $VERTICADATA -R

# install Vertica rpm
ADD vertica-7.1.0-2.x86_64.RHEL5.rpm /tmp/vertica-7.1.0-2.x86_64.RHEL5.rpm
RUN yum -q -y localinstall /tmp/vertica-7.1.0-2.x86_64.RHEL5.rpm

# save some disk space
RUN yum clean all

ADD ./docker-vertica.sh /opt/vertica/bin/
CMD ["/opt/vertica/bin/docker-vertica.sh"]

EXPOSE 5433
