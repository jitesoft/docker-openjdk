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

RUN apk add --no-cache --virtual .build tar curl \
 && curl -OsS https://download.java.net/java/early_access/alpine/19/binaries/${JAVA_FILE} \
 && curl -OsS https://download.java.net/java/early_access/alpine/19/binaries/${JAVA_FILE}.sha256 \
 && echo "$(cat ${JAVA_FILE}.sha256) */${JAVA_FILE}" | sha256sum -c - \
 && tar -xzf ${JAVA_FILE} \
 && mv jdk-13 jdk \
 && rm ${JAVA_FILE} ${JAVA_FILE}.sha256 \
 # Memory fix.
 && java -Xshare:dump \
 && apk del .build


CMD [ "jshell" ]
