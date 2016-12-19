FROM       openjdk:8-alpine
MAINTAINER Viacheslav Kalashnikov <xemuliam@gmail.com>
ARG        DIST_MIRROR=http://public-repo-1.hortonworks.com
ARG        VERSION=2.0.1.0
ARG        REVISION=12
ENV        HDF_HOME=/opt/hdf
RUN        apk update && apk add --upgrade bash curl && \
           mkdir -p ${HDF_HOME} && \
           curl ${DIST_MIRROR}/HDF/${VERSION}/HDF-${VERSION}-${REVISION}.tar.gz | tar xvz -C ${HDF_HOME} && \
           mv ${HDF_HOME}/HDF-${VERSION}/nifi/* ${HDF_HOME} && \
           rm -rf ${HDF_HOME}/HDF-${VERSION}/nifi && \
           rm -rf *.tar.gz && \
           apk del curl && \
           rm -rf /var/cache/apk/*
EXPOSE     8080 8081 8443
VOLUME     ${HDF_HOME}/logs \
           ${HDF_HOME}/flowfile_repository \
           ${HDF_HOME}/database_repository \
           ${HDF_HOME}/content_repository \
           ${HDF_HOME}/provenance_repository
WORKDIR    ${HDF_HOME}
CMD        ./bin/nifi.sh run
