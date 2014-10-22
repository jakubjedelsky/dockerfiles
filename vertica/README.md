# Docker & Vertica

Let's build a docker container with [Vertica](http://www.vertica.com) running inside. Heavily inspired by [bluelabsio/docker-vertica](https://github.com/bluelabsio/docker-vertica).

This is for testing purposes only due to bad magic inside. Don't try to use it in production environment. Or try but don't cry later.

## Build it
Attach your vertica rpm next to Dockerfile (you can donload it on http://my.vertica.com) and run:
```bash
docker build -t vertica .
```

## Run it
```bash
docker run -d -p 5433:5433 -i vertica
```

You can mount persistent volume ...
```bash
docker run -d -p 5433:5433 -v /tmp/vertica:/data -i vertica
```

... and specify your database name ~~and user~~:
```bash
docker run -d -p 5433:5433 -e DBNAME=supertruperdatabase -i vertica
```
## Connect
```bash
vsql -U vertica -d verticadb
```
