FROM blazegraph

ENV VERSION_NUMBER=1.0.0-gk
ENV JAVA_HOME=/usr/lib/jvm/java

EXPOSE 10214 3000

RUN wget -O - https://rpm.nodesource.com/setup_10.x | bash -

RUN wget https://bintray.com/sbt/rpm/rpm \
    --output-document=/etc/yum.repos.d/bintray--sbt-rpm.repo

RUN wget https://dl.yarnpkg.com/rpm/yarn.repo \
    --output-document=/etc/yum.repos.d/yarn.repo

RUN yum --assumeyes \
    install \
        unzip \
        sbt \
        epel-release \
        nodejs \
        gcc-c++ make \
        yarn

RUN git clone https://github.com/researchspace/researchspace.git && \
    cd researchspace && \
    git checkout 8671757b3091f38639923410c7d985fba267c1fd

# See: 
# https://github.com/researchspace/researchspace#building-war-artefact

# Force SBT modules and dependencies to load
RUN cd researchspace && \
    rm -rf project/webpack/assets && \
    sh ./build.sh \
        -Dbuildjson=researchspace/researchspace-root-build.json \
        -DbuildEnv=prod \
        clean

# Now build package
RUN cd researchspace && \
    sh ./build.sh \
        -DplatformVersion=$VERSION_NUMBER \
        -Dbuildjson=researchspace/researchspace-root-build.json \
        -DbuildEnv=prod \
        package

# Copy script to run ResearchSpace
COPY start-researchspace.sh /

# ---- other stuff tried, not used ----

# See:
# /researchspace/metaphacts-platform/dist/docker/platform/Readme.md

# RUN cd researchspace && \
#     ./build.sh \
#         -DbuildEnv=prod \
#         -Dbuildjson=./researchspace/researchspace-root-build.json \
#         -DplatformVersion=3.2.0 \
#         platformZip
# 
# RUN cd researchspace && \
#     ./build.sh -no-colors \
#         -DbuildEnv=prod \
#         -Dbuildjson=./researchspace/researchspace-root-build.json \
#         -DplatformVersion=3.2.0 \
#         platformZip

# See: 
# https://github.com/researchspace/researchspace#running-the-researchspace-in-development-mode

# RUN cd researchspace && \
#     mkdir -p runtime/config && \
#     echo "sparqlEndpoint=http://localhost:10080/blazegraph/sparql" \
#         >> runtime/config/environment.prop && \
#     sh ./build.sh -Dbuildjson=researchspace/researchspace-root-build.json

# RUN cd researchspace && \
#     ./build.sh \
#     -Dbuildjson=researchspace/researchspace-root-build.json \
#     compile
# 
# RUN cd researchspace && \
#     unzip example-data/blazegraph.jnl.zip -d example-data/ && \
#     unzip example-data/assets.zip -d metaphactory/data/

# ----
