FROM       openjdk:8-alpine
MAINTAINER Viacheslav Kalashnikov <xemuliam@gmail.com>
ARG        DIST_MIRROR=http://public-repo-1.hortonworks.com/HDF/centos6/2.x/updates/2.1.0.0/tars/nifi/nifi-1.1.0.2.1.0.0-165-bin.tar.gz
ARG        VERSION=1.1.0.2.1.0.0-165
ENV        HDF_HOME=/opt/hdf
RUN        apk update && apk add --upgrade curl && \
           mkdir -p ${HDF_HOME} && \
           curl ${DIST_MIRROR} | tar xvz -C ${HDF_HOME} && \
           mv ${HDF_HOME}/nifi-${VERSION}-${REVISION}/* ${HDF_HOME} && \
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
