# Load MMM data to Blazegraph instance
# Assumes researchspace setup cloned from antheia.

export JAVA_HOME=/usr/lib/jvm/java
export ANTHEIA_FILES=/home/researchspace/antheia
export RS_BUNDLE=${ANTHEIA_FILES}/researchspace
export JETTY_DIST=${RS_BUNDLE}/jetty-distribution-9.2.13.v20150730
export BLAZEGRAPH_LIB=${JETTY_DIST}/webapps/blazegraph/WEB-INF/lib
export BLAZEGRAPH_CP=${BLAZEGRAPH_LIB}/bigdata-runtime-2.2.0-SNAPSHOT.jar
export BLAZEGRAPH_DATALOADER=com.bigdata.rdf.store.DataLoader
export BLAZEGRAPH_TEXTINDEX=com.bigdata.rdf.store.RebuildTextIndex
# export LOG4J_CONFIG="file://$JETTY_DIST/webapps/ROOT/etc/log4j2.xml"
export LOG4J_CONFIG="file://$JETTY_DIST/webapps/blazegraph/WEB-INF/classes/log4j.properties"

export START_DIR=$(pwd)

cd $ANTHEIA_FILES

# Copy and unzip file with MMM data
# unzip mmm-data_orig.zip -d ./mmm_data
# Copy and unzip "mmm-fuseki-master", which has additional schema files
# unzip mmm-fuseki-master_orig.zip -d ./mmm_data

# Load data into Blazegraph/ResearchSpace instance
#
# See:
# https://github.com/natuk/oxlod-plumbing/wiki/Bodleian-MMM#endpoint
# https://github.com/mapping-manuscript-migrations/mmm-fuseki/blob/master/Dockerfile
# https://stackoverflow.com/questions/37796254/loading-triples-into-blazegraph-using-the-bulk-data-loader
#

java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
     -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
     -namespace mmm                     \
     -defaultGraph http://ldf.fi/mmm/   \
     $ANTHEIA_FILES/fastload.properties \
     $ANTHEIA_FILES/mmm_data/mmm_bibale.ttl

java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
     -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
     -namespace mmm                     \
     -defaultGraph http://ldf.fi/mmm/   \
     $ANTHEIA_FILES/fastload.properties \
     $ANTHEIA_FILES/mmm_data/mmm_bodley.ttl

java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
     -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
     -namespace mmm                     \
     -defaultGraph http://ldf.fi/mmm/   \
     $ANTHEIA_FILES/fastload.properties \
     $ANTHEIA_FILES/mmm_data/mmm_places.ttl

java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
     -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
     -namespace mmm                     \
     -defaultGraph http://ldf.fi/mmm/   \
     $ANTHEIA_FILES/fastload.properties \
     $ANTHEIA_FILES/mmm_data/mmm_sdbm.ttl

java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
     -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
     -namespace mmm                          \
     -defaultGraph http://ldf.fi/schema/mmm/ \
     $ANTHEIA_FILES/fastload.properties      \
     $ANTHEIA_FILES/mmm_data/schema.ttl

java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG \
     -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
     -namespace mmm                       \
     -defaultGraph http://ldf.fi/mmm/void \
     $ANTHEIA_FILES/fastload.properties   \
     $ANTHEIA_FILES/mmm_data/void.ttl

java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG  \
     -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
     -namespace mmm                              \
     -defaultGraph http://ldf.fi/schema/mmm/     \
     $ANTHEIA_FILES/fastload.properties          \
     /mmm_data/mmm-fuseki-master/schema/mmm-schema.ttl

java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG  \
     -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
     -namespace mmm                              \
     -defaultGraph http://ldf.fi/schema/mmm/     \
     $ANTHEIA_FILES/fastload.properties          \
     $ANTHEIA_FILES/mmm_data/mmm-fuseki-master/schema/cidoc-crm.rdf

java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG  \
     -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_DATALOADER} \
     -namespace mmm                              \
     -defaultGraph http://ldf.fi/schema/mmm/     \
     $ANTHEIA_FILES/fastload.properties          \
     $ANTHEIA_FILES/mmm_data/mmm-fuseki-master/schema/frbroo.rdf

java -Xmx4g -Dlog4j.configuration=$LOG4J_CONFIG  \
     -cp "$BLAZEGRAPH_CP:$BLAZEGRAPH_LIB/*" ${BLAZEGRAPH_TEXTINDEX} \
     -namespace mmm      -forceCreate            \
     $RS_BUNDLE/RWStore.properties

cd $START_DIR

# End.
