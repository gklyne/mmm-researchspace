FROM centos:8

RUN yum --assumeyes \
    install net-tools git which wget unzip vim \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel

ENV VERSION_NUMBER=1.0.0-gk
ENV JAVA_HOME=/usr/lib/jvm/java
ENV RS_BUNDLE=/researchspace-3.4-preview-bundle
ENV JETTY_DIST=${RS_BUNDLE}/jetty-distribution
ENV BLAZEGRAPH_LIB=${JETTY_DIST}/webapps/blazegraph/WEB-INF/lib
ENV BLAZEGRAPH_CP=${BLAZEGRAPH_LIB}/bigdata-runtime-2.2.0-SNAPSHOT.jar
ENV BLAZEGRAPH_DATALOADER=com.bigdata.rdf.store.DataLoader
ENV BLAZEGRAPH_TEXTINDEX=com.bigdata.rdf.store.RebuildTextIndex
# ENV LOG4J_CONFIG="file://$JETTY_DIST/webapps/ROOT/etc/log4j2.xml"
ENV LOG4J_CONFIG="file://$JETTY_DIST/webapps/blazegraph/WEB-INF/classes/log4j.properties"

EXPOSE 10214 3000

# Copy and unzip file with ResearchSpace preview
COPY researchspace-3.4-preview-bundle.zip /
RUN unzip /researchspace-3.4-preview-bundle.zip

# Copy and unzip file with MMM data
COPY mmm_data.zip /
RUN unzip /mmm_data.zip -d /mmm_data

# Copy and unzip "mmm-fuseki-master", whish has additional schema files
COPY mmm-fuseki-master.zip /
RUN unzip /mmm-fuseki-master.zip -d /mmm-fuseki-master

# Load data into Blazegraph/ResearchSpace instance
#
# See:
# https://github.com/natuk/oxlod-plumbing/wiki/Bodleian-MMM#endpoint
# https://github.com/mapping-manuscript-migrations/mmm-fuseki/blob/master/Dockerfile
# https://stackoverflow.com/questions/37796254/loading-triples-into-blazegraph-using-the-bulk-data-loader
#
#

COPY fastload.properties /$RS_BUNDLE
RUN cd $RS_BUNDLE && \
    java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
         -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
         -namespace kb                    \
         -defaultGraph http://ldf.fi/mmm/ \
         $RS_BUNDLE/fastload.properties   \
         /mmm_data/mmm_bibale.ttl &&      \
    java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
         -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
         -namespace kb                    \
         -defaultGraph http://ldf.fi/mmm/ \
         $RS_BUNDLE/fastload.properties   \
         /mmm_data/mmm_bodley.ttl      && \
    java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
         -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
         -namespace kb                    \
         -defaultGraph http://ldf.fi/mmm/ \
         $RS_BUNDLE/fastload.properties   \
         /mmm_data/mmm_places.ttl      && \
    java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
         -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
         -namespace kb                    \
         -defaultGraph http://ldf.fi/mmm/ \
         $RS_BUNDLE/fastload.properties   \
         /mmm_data/mmm_sdbm.ttl        && \
    java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
         -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
         -namespace kb                           \
         -defaultGraph http://ldf.fi/schema/mmm/ \
         $RS_BUNDLE/fastload.properties          \
         /mmm_data/schema.ttl                 && \
    java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
         -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
         -namespace kb                        \
         -defaultGraph http://ldf.fi/mmm/void \
         $RS_BUNDLE/fastload.properties       \
         /mmm_data/void.ttl                && \
    java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
         -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
         -namespace kb                               \
         -defaultGraph http://ldf.fi/schema/mmm/     \
         $RS_BUNDLE/fastload.properties              \
         /mmm-fuseki-master/schema/mmm-schema.ttl && \
    java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
         -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
         -namespace kb                               \
         -defaultGraph http://ldf.fi/schema/mmm/     \
         $RS_BUNDLE/fastload.properties              \
         /mmm-fuseki-master/schema/cidoc-crm.rdf  && \
    java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
         -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
         -namespace kb                               \
         -defaultGraph http://ldf.fi/schema/mmm/     \
         $RS_BUNDLE/fastload.properties              \
         /mmm-fuseki-master/schema/frbroo.rdf     && \
    java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG  \
         -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_TEXTINDEX} \
         -namespace kb -forceCreate    \
         $RS_BUNDLE/RWStore.properties

# java -cp blazegraph.jar com.bigdata.rdf.store.RebuildTextIndex [-namespace namespace] [-forceCreate] propertyFile


# java -cp /home/blazegraph/blazegraph-2.1.4.jar com.bigdata.rdf.store.DataLoader -defaultGraph https://medieval.bodleian.ox.ac.uk/ -namespace mmm /home/blazegraph/fastload.properties /home/thanasis/mmm/*.ttl


# Copy start script
#
# To start:
# . start-researchspace.sh
#
# NOTE: to run the demo, I've edited the researchspace `start.sh`
# to add `-Xmx4g` to the java command line

COPY start.sh /researchspace-3.4-preview-bundle
COPY start-researchspace.sh /

# ----
