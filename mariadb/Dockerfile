FROM mattdm/fedora
MAINTAINER "Jakub Jedelsky" <jakub.jedelsky@gmail.com>

RUN yum -y update
RUN yum -y install mariadb-server
RUN yum clean all

ADD rundb.sh /usr/bin/rundb.sh

EXPOSE 3306
CMD ["/usr/bin/rundb.sh"]
