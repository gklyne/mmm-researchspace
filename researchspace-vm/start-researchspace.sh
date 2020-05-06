echo "Starting ResearchSpace.  This could take a while..."

cd ${RS_WORKINGDIR}/researchspace
sbt -Dbuildjson=researchspace/researchspace-root-build.json  ~jetty:start
