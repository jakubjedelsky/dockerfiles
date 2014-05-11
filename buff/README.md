Dockerfile for [buff app](https://github.com/starenka/buff).

You need to link [redis](../redis) container as "db", eg.:

    docker build -t buff .
    docker run -d --link redis:db -p 8080 buff
