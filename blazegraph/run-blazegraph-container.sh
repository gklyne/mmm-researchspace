# Run docker containmer containing blazegraph

echo "Use 'ifconfig' in the running system to find the IP address for 'eth1'"
echo "Run '. start-blazeraph.sh' in the running system.  Ignore the displayed IP address."
echo "Browse to 'http://<IP-address>:9999/blazegraph/' from the host system."

docker run -it --network=host blazegraph

