# Build ResearchSpace instance
#
# Run from working directory using `source` (`.`) command.

export VERSION_NUMBER=1.0.0-gk
export JAVA_HOME=/usr/lib/jvm/java
export RS_WORKINGDIR=$(pwd)

# EXPOSE 10214 3000

# Install build tools

sudo wget -O - https://rpm.nodesource.com/setup_10.x | sudo bash -

sudo wget https://bintray.com/sbt/rpm/rpm \
    --output-document=/etc/yum.repos.d/bintray--sbt-rpm.repo

sudo wget https://dl.yarnpkg.com/rpm/yarn.repo \
    --output-document=/etc/yum.repos.d/yarn.repo

sudo yum --assumeyes install \
        unzip \
        sbt \
        epel-release \
        nodejs \
        gcc-c++ make \
        yarn

# Get ResearchSpace git repo, and make version 2.1 current checkout.
cd ${RS_WORKINGDIR}/github
git clone https://github.com/researchspace/researchspace.git

cd ${RS_WORKINGDIR}/github/researchspace
git checkout 8671757b3091f38639923410c7d985fba267c1fd

# See: 
# https://github.com/researchspace/researchspace#building-war-artefact

# Force SBT modules and dependencies to load

# Check SBT verion in `project/build.properties`
# e.g. sbt.version=0.13.16
# Trying latest STB version: 1.3.10

# Try removing project/repositories:
# that appears to configure a proxy maven repo used to access SBT packages
# This allows me to get further, but still fails.
#
# researchspace/project/repositories:
# 
#     [repositories]
#       local
#       metaphacts-ivy-proxy-releases: https://nexus.grapphs.com/repository/sbt/, [organization]/[module]/(scala_[scalaVersion]/)(sbt_[sbtVersion]/)[revision]/[type]s/[artifact](-[classifier]).[ext]
#       metaphacts-maven-proxy-releases: https://nexus.grapphs.com/repository/maven/
#     
# project/plugins.sbt:
#
#       addSbtPlugin("com.typesafe.sbteclipse" % "sbteclipse-plugin" % "5.1.0")
#       addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.8.2")
#       addSbtPlugin("com.earldouglas" % "xsbt-web-plugin" % "3.0.1")
#       addSbtPlugin("com.typesafe.sbt" % "sbt-license-report" % "1.1.0")
#       addSbtPlugin("de.heikoseeberger" % "sbt-header" % "2.0.0")
#       addSbtPlugin("com.banno" % "sbt-license-plugin" % "0.1.5")
#       addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.14.0")
#       addSbtPlugin("com.etsy" % "sbt-checkstyle-plugin" % "3.0.0")
#       addSbtPlugin("com.github.mpeltonen" % "sbt-idea" % "1.6.0")
#       addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-RC3")
#

# Three projects had to change .yarnrc and .npmrc to remove repository reference, 
# then re-run yarn on each:
# 
#     metaphacts/web
#     researchspace/web
#     project/webpack
# 
# Also install libpng-devel (libpng-dev on Debian)

cd ${RS_WORKINGDIR}/github/researchspace

rm -rf project/webpack/assets

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

cd ${RS_WORKINGDIR}

# ----
