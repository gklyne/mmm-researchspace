FROM centos:8

RUN yum --assumeyes \
    install net-tools git which wget unzip vim \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel

ENV VERSION_NUMBER=1.0.0-gk
ENV JAVA_HOME=/usr/lib/jvm/java

EXPOSE 10214 3000

# Copy ZIP file with ResearchSpace demo
COPY researchspace-3.4-preview-demo-bundle.zip /

# Unzip
RUN unzip /researchspace-3.4-preview-demo-bundle.zip && \
    mv    researchspace-3.4-preview-demo-bundle researchspace-3.2-bundle

# ZIP file created using:
#
#   git archive -o researchspace-3.2-bundle.zip \
#               --prefix=researchspace-3.2-bundle/ \
#               HEAD
#
# (With git HEAD set to the 3.2 release)
# (commit 0b7668eb9e1e1a9f606bbaae4d7e2ab78ab5f68a)
#
# Copy ZIP file with ResearchSpace demo
COPY researchspace-3.2-bundle.zip /

# Unzip
RUN unzip /researchspace-3.2-bundle.zip

# cd researchspace-3.2-bundle

# Copy start script
#
# To start:
# . start-researchspace.sh
#
# NOTE: to run the demo, I've edited the researchspace `start.sh`
# to add `-Xmx4g` to the java command line

COPY start.sh /researchspace-3.2-bundle
COPY start-researchspace.sh /

# ----
