FROM centos:8

RUN yum --assumeyes \
    install net-tools git which wget unzip vim \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel

ENV VERSION_NUMBER=1.0.0-gk
ENV JAVA_HOME=/usr/lib/jvm/java

EXPOSE 10214 3000

# Copy ZIP file with ResearchSpace preview
COPY researchspace-3.4-preview-bundle.zip /

# Unzip

RUN unzip /researchspace-3.4-preview-bundle.zip
# cd researchspace-3.4-preview-bundle

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
