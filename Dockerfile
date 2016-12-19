FROM       openjdk:7-alpine
MAINTAINER Viacheslav Kalashnikov <xemuliam@gmail.com>
ARG        DIST_MIRROR=http://d3d0kdwqv675cq.cloudfront.net/HDF/centos6/1.x/updates/1.2.0.1/HDF-1.2.0.1-1.tar.gz
ARG        VERSION=1.2.0.1-1
ENV        HDF_HOME=/opt/hdf
RUN        apk update && apk add --upgrade bash curl && \
           mkdir -p ${HDF_HOME} && \
           curl ${DIST_MIRROR} | tar xvz -C ${HDF_HOME} && \
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
