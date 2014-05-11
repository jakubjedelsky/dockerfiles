FROM centos

RUN yum -y update
RUN yum -y localinstall http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum -y install python python-libs python-virtualenv gcc git patch
RUN yum clean all

RUN mkdir /opt/buff
WORKDIR /opt/buff
RUN git clone https://github.com/starenka/buff.git .
RUN virtualenv .env && source .env/bin/activate
RUN .env/bin/pip install -r requirements.pip
RUN .env/bin/pip install werkzeug

ADD 001_buff-redis-server.patch /opt/buff/
RUN patch -p0 app.py < 001_buff-redis-server.patch

EXPOSE 8080

ENTRYPOINT ["/opt/buff/.env/bin/uwsgi"]
CMD ["--http", ":8080", "--wsgi-file", "/opt/buff/app.py", "--uid", "99", "--master"]
