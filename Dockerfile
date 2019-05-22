FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft - https://jitesoft.com" \
      maintainer.repo="https://gitlab.com/jitesoft/dockerfiles/openjdk" \
      maintainer.issues="https://gitlab.com/jitesoft/dockerfiles/openjdk/issues" \
      jdk.version="13-ea+19"

ARG JAVA_FILE="openjdk-13-ea+19_linux-x64-musl_bin.tar.gz"
ENV JAVA_HOME="/jdk" \
    LANG="C.UTF-8" \
    PATH="$PATH:/jdk/bin"

RUN wget -O /openjdk.tar.gz https://download.java.net/java/early_access/alpine/19/binaries/${JAVA_FILE} \
 && wget -qO- https://download.java.net/java/early_access/alpine/19/binaries/${JAVA_FILE}.sha256 | xargs printf "%s */openjdk.tar.gz" | sha256sum -c - \
 && mkdir /jdk \
 && tar --extract --file /openjdk.tar.gz --directory=/jdk --strip-components 1 \
 && rm /openjdk.tar.gz \
 # Memory fix.
 && java -Xshare:dump

CMD [ "jshell" ]


