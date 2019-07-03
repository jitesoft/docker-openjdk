FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/openjdk" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/openjdk/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/openjdk" \
      com.jitesoft.app.jdk.version="13-ea+27"

ARG JAVA_FILE="openjdk-13-ea+27_linux-x64-musl_bin.tar.gz"
ENV JAVA_HOME="/jdk" \
    LANG="C.UTF-8" \
    PATH="$PATH:/jdk/bin"

RUN wget -O /openjdk.tar.gz https://download.java.net/java/early_access/alpine/27/binaries/${JAVA_FILE} \
 && wget -qO- https://download.java.net/java/early_access/alpine/19/binaries/${JAVA_FILE}.sha256 | xargs printf "%s */openjdk.tar.gz" | sha256sum -c - \
 && mkdir /jdk \
 && tar --extract --file /openjdk.tar.gz --directory=/jdk --strip-components 1 \
 && rm /openjdk.tar.gz \
 # Memory fix.
 && java -Xshare:dump

CMD [ "jshell" ]
