# Create docker image running blazegraph

docker build . -t blazegraph

echo "Run Blazeraph container with this command:"
echo " "
echo "docker run -it --network=host blazegraph"
echo " "
echo "Use 'ifconfig' in the running system to find the IP address for @@@"
echo "Run '. start-blazeraph.sh' in the running system.  Ignore the displayed IP address."
echo "Browse to 'http://<IP-address>:9999/blazegraph/' from the host system."

