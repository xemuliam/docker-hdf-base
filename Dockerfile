FROM       openjdk:8-alpine
MAINTAINER Viacheslav Kalashnikov <xemuliam@gmail.com>
ARG        DIST=http://public-repo-1.hortonworks.com/HDF/2.1.1.0/nifi-1.1.0.2.1.1.0-2-bin.tar.gz
ARG        VERSION=1.1.0.2.1.1.0-2
ENV        HDF_HOME=/opt/hdf
RUN        apk update && apk add --upgrade bash curl && \
           mkdir -p ${HDF_HOME} && \
            curl ${DIST} | tar xvz -C ${HDF_HOME} && \
           mv ${HDF_HOME}/nifi-${VERSION}/* ${HDF_HOME} && \
           rm -rf ${HDF_HOME}/nifi-${VERSION} && \
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
