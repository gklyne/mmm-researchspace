# Create new user using "adduser"; e.g. 
#     useradd researchspace
# Add new user to group wheel; e.g.
#     usermod researchspace -a -G wheel
#

sudo yum --assumeyes \
    install net-tools git which wget \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel

wget --output-document=blazegraph-2.1.5.jar \
    https://sourceforge.net/projects/bigdata/files/bigdata/2.1.5/blazegraph.jar/download 
    
echo "To start BlazeGraph:"
echo "  java -server -Xmx4g -jar blazegraph-2.1.5.jar &"
echo "or"
echo "  . start-blazegraph.sh"

