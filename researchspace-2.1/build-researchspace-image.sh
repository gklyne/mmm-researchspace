# Create docker image running researchspace demo

docker build . -t researchspace-2-1

echo "Run ResearchSpace container with this command:"
echo " "
echo ". run-researchspace-container.sh"
echo " "
echo "Run '. start-researchspace.sh' in the running system."
echo "Browse to 'http://localhost:10214' from the host system."

