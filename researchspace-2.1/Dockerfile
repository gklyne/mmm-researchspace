FROM centos:8

RUN yum --assumeyes \
    install net-tools git which wget unzip vim \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel

ENV VERSION_NUMBER=2.1.0-gk
ENV JAVA_HOME=/usr/lib/jvm/java

EXPOSE 10214 3000

# Copy ZIP file with ResearchSpace demo
COPY researchspace-3.4-preview-demo-bundle.zip /

# Unzip
RUN unzip /researchspace-3.4-preview-demo-bundle.zip && \
    rm -rfv researchspace-3.4-preview-demo-bundle/apps/custom-app-id && \
    mv -v researchspace-3.4-preview-demo-bundle researchspace-bundle

# ZIP file created using:
#
#   git archive -o researchspace-3.2-bundle.zip \
#               --prefix=researchspace-3.2-bundle/ \
#               HEAD
#
# (With git HEAD set to the 2.1 release)
# (commit 76a238ee05af13bbb652484b41d26f5f86ab11e9)
#
# Copy ZIP file with ResearchSpace demo
# COPY researchspace-3.2-bundle.zip /
#
# Unzip
# RUN unzip /researchspace-3.2-bundle.zip

# Copy ResearchSpace 2.1 bundle files from current repo to target
# These include edited custom app details

COPY researchspace-2.1-bundle /researchspace-bundle

# @@TODO later?  Unzip original then copy over updated files?

# Copy start script
#
# To start:
# . start-researchspace.sh
#
# NOTE: to run the demo, I've edited the researchspace `start.sh`
# to add `-Xmx4g` to the java command line

COPY start.sh /researchspace-bundle
COPY start-researchspace.sh /

# ----
