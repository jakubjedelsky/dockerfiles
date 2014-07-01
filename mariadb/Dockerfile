FROM mattdm/fedora

RUN yum -y update
RUN yum -y install mariadb-server
RUN /usr/libexec/mariadb-prepare-db-dir

EXPOSE 3306
CMD ["/usr/bin/mysqld_safe","--basedir=/usr"]
