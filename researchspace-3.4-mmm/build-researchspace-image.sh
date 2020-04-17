# Create docker image running researchspace preview with MMM data

docker build . -t researchspace-mmm

docker tag researchspace-mmm:latest gklyne/researchspace-mmm:latest

# docker push gklyne/mmm-researchspace

echo "Run ResearchSpace container with this command:"
echo " "
echo ". run-researchspace-container.sh"
echo " "
echo "Run '. start-researchspace.sh' in the running system."
echo "Browse to 'http://localhost:10214' from the host system."

