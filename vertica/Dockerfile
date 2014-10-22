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

# install vertica with its magic script.
# there will be a lot of errors, so we silently ignore it. Magic!
#RUN /opt/vertica/sbin/install_vertica --host localhost \
#    --license CE \
#    --accept-eula \
#    --dba-user vertica \
#    --dba-group vertica \
#    --dba-user-password-disabled \
#    --data-dir /data \
#    --tmp-dir /data \
#    --point-to-point \
#    --spread-logging \
#    --failure-threshold NONE \
#    --no-system-configuration

# create database
# !!! it should be allowed from docker 1.3.0 !!!
#USER $DBUSER
#USER vertica
#RUN /opt/vertica/bin/admintools -t create_db -s localhost -d verticadb -D /data

ADD ./docker-vertica.sh /opt/vertica/bin/
CMD ["/opt/vertica/bin/docker-vertica.sh"]

EXPOSE 5433
