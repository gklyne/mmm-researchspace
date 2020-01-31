echo "Starting ResearchSpace.  This could take a while..."

cd /researchspace
sbt -Dbuildjson=researchspace/researchspace-root-build.json  ~jetty:start
