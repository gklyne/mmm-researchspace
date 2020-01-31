FROM centos:8

RUN yum --assumeyes \
    install net-tools git which wget \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel

# Assume that blazegraph-2.1.5.jar is available in the build context.
# I'm using the current working directory.
COPY blazegraph-2.1.5.jar /root/blazegraph-2.1.5.jar
COPY start-blazeraph.sh /

