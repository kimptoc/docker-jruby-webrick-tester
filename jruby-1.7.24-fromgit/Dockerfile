# Creates alpine based java environment
#

FROM alpine:3.3
MAINTAINER kimptoc - chris@kimptoc.net

ENV HTTP_PROXY http://proxy.eu.rabodev.com:8080
ENV HTTPS_PROXY http://proxy.eu.rabodev.com:8080
ENV http_proxy http://proxy.eu.rabodev.com:8080
ENV https_proxy http://proxy.eu.rabodev.com:8080

RUN echo http://nl.alpinelinux.org/alpine/v3.3/main >> /etc/apk/repositories  \
RUN echo http://nl.alpinelinux.org/alpine/v3.3/main >> /etc/apk/repositories  \
RUN echo http://dl-2.alpinelinux.org/alpine/v3.3/main >> /etc/apk/repositories  \
RUN echo http://dl-3.alpinelinux.org/alpine/v3.3/main >> /etc/apk/repositories  \
RUN echo http://dl-4.alpinelinux.org/alpine/v3.3/main >> /etc/apk/repositories  \
RUN echo http://dl-5.alpinelinux.org/alpine/v3.3/main >> /etc/apk/repositories  \
RUN echo http://mirror.yandex.ru/mirrors/alpine/v3.3/main >> /etc/apk/repositories \
RUN echo http://repos.lax-noc.com/alpine/v3.3/main >> /etc/apk/repositories        \
RUN echo http://distrib-coffee.ipsl.jussieu.fr/pub/linux/alpine/alpine/v3.3/main >> /etc/apk/repositories \
RUN apk update

# java jdk and dev tools
RUN apk add git curl openjdk7 --update \
    && rm -rf /var/cache/apk/*

ENV JAVA_HOME /usr/lib/jvm/default-jvm/jre
ENV PATH $PATH:$JAVA_HOME/bin
RUN rm /usr/bin/java && ln -s $JAVA_HOME/bin/java /usr/bin/java

RUN mkdir -p /usr/local/jruby
WORKDIR /app/jruby-drb-test
VOLUME /app/jruby-drb-test

# jruby
#RUN cd /usr/local/jruby && wget -q https://s3.amazonaws.com/jruby.org/downloads/1.7.24/jruby-complete-1.7.24.jar
RUN cd /usr/local/jruby && git clone https://github.com/jruby/jruby
#RUN cd /usr/local/jruby/jruby && git checkout 1.7.24
RUN cd /usr/local/jruby/jruby && git checkout 04bdbd5ab99e63a4c60f54c7f150d40fa88d472b

ENTRYPOINT ["java","-cp", "/usr/local/jruby/jruby-complete-1.7.24.jar","org.jruby.Main"]
