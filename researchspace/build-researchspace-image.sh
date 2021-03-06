# Create docker image running researchspace

docker build . -t researchspace

echo "Run ResearchSpace container with this command:"
echo " "
echo ". run-researchspace-container.sh"
echo " "
echo "Use 'ifconfig' in the running system to find the IP address for 'eth1'"
echo "Run '. start-researchspace.sh' in the running system."
echo "Browse to 'http://<IP-address>:10214' from the host system."

