# Build ResearchSpace instance
#
# Run from working directory using `source` (`.`) command.

export VERSION_NUMBER=1.0.0-gk
export JAVA_HOME=/usr/lib/jvm/java
export RS_WORKINGDIR=$(pwd)

# EXPOSE 10214 3000

# Install build tools

sudo wget -O - https://rpm.nodesource.com/setup_10.x | bash -

sudo wget https://bintray.com/sbt/rpm/rpm \
    --output-document=/etc/yum.repos.d/bintray--sbt-rpm.repo

sudo wget https://dl.yarnpkg.com/rpm/yarn.repo \
    --output-document=/etc/yum.repos.d/yarn.repo

yum --assumeyes install \
        unzip \
        sbt \
        epel-release \
        nodejs \
        gcc-c++ make \
        yarn

# Get ResearchSpace git repo, and make version 2.1 current checkout.
git clone https://github.com/researchspace/researchspace.git && \
    cd ${RS_WORKINGDIR}/researchspace \
    git checkout 8671757b3091f38639923410c7d985fba267c1fd

# See: 
# https://github.com/researchspace/researchspace#building-war-artefact

# Force SBT modules and dependencies to load
cd ${RS_WORKINGDIR}/researchspace && \
    rm -rf project/webpack/assets && \
    sh ./build.sh \
        -Dbuildjson=researchspace/researchspace-root-build.json \
        -DbuildEnv=prod \
        clean

# Now build package
    sh ./build.sh \
        -DplatformVersion=$VERSION_NUMBER \
        -Dbuildjson=researchspace/researchspace-root-build.json \
        -DbuildEnv=prod \
        package

# ----
