FROM centos:8

RUN yum --assumeyes \
    install net-tools git which wget unzip vim \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel

ENV VERSION_NUMBER=1.0.0-gk
ENV JAVA_HOME=/usr/lib/jvm/java
ENV RS_BUNDLE=/researchspace-3.4-preview-bundle
ENV JETTY_DIST=${RS_BUNDLE}/distribution
ENV BLAZEGRAPH_LIB=${JETTY_DIST}/webapps/blazegraph/WEB-INF/lib
ENV BLAZEGRAPH_CP=${BLAZEGRAPH_LIB}/bigdata-runtime-2.2.0-SNAPSHOT.jar
ENV BLAZEGRAPH_DATALOADER=com.bigdata.rdf.store.DataLoader

EXPOSE 10214 3000

# Copy and unzip file with ResearchSpace preview
COPY researchspace-3.4-preview-bundle.zip /
RUN unzip /researchspace-3.4-preview-bundle.zip

# Copy and unzip file with MMM data
COPY mmm_data.zip /
RUN unzip /mmm_data.zip -d /mmm_data

# Load data into Blazegraph/ResearchSpace instance
# @@@@@
# ${BLAZEGRAPH_CP}/rdf/store/DataLoader.class
#
#

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
