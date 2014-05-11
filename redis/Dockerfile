FROM centos
RUN yum -y update
# install EPEL
RUN yum -y localinstall http://ftp.linux.cz/pub/linux/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
# and redis
RUN yum -y install redis
EXPOSE 6379
ENTRYPOINT ["/usr/sbin/redis-server"]
