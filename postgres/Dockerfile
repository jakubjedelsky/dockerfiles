FROM centos

RUN yum -y update
RUN rpm -Uvh http://yum.postgresql.org/9.3/redhat/rhel-7-x86_64/pgdg-centos93-9.3-1.noarch.rpm
RUN yum -y install postgresql93-server postgresql93

ADD setup-pg.sh /tmp/

ENV PGDATA /var/lib/pgsql/9.3/data/

USER postgres
RUN /bin/bash /tmp/setup-pg.sh

RUN echo "host all  all    0.0.0.0/0  md5" >> $PGDATA/pg_hba.conf
RUN echo "listen_addresses='*'" >> $PGDATA/postgresql.conf

EXPOSE 5432

CMD ["/usr/pgsql-9.3/bin/postgres", "-D", "/var/lib/pgsql/9.3/data/"]
