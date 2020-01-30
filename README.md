# Create and run Docker containers for Blazegraph and ResearchSpace

This project contains files, scripts and other resources for creating Docker containers for Blazegraph and ResearchSpace.

The blazegraph JAR file (blazegraph-2.1.5.jar) i downloaded from:

    https://sourceforge.net/projects/bigdata/files/bigdata/2.1.5/blazegraph.jar/download

E.g.

    wget https://sourceforge.net/projects/bigdata/files/bigdata/2.1.5/blazegraph.jar/download --output-document=blazegraph-2.1.5.jar

This local copy is referenced in the blazegraph/Dockerfile script.


## MacOS preliminaries

These instructions are based on the "Docker toolbox" kit (not the more recent "Docker desktop", which requires a newer version of MacOS than I am running, and handles virtualization and networking somewhat differently).

1. Install VirtualBox if not already installed (@@details?)

2. Install Docker toolbox if not already installed (download and run https://github.com/docker/toolbox/releases/download/v19.03.1/DockerToolbox-19.03.1.pkg)

2. Run Applications > Docker > "Docker Quickstaret Terminal" (e.g. from spotlight search) to create a new terminal session with access to a running docker daemon.

3. Subsequenet commands are entered in the new terminal window.  (Note: the Docker daemon is not accessible from other terminal windows.)


## Blazegraph

    cd ./blazegraph
    . build-blazegraph-image.sh
    . run-blazegraph-container.sh

Then, in the resulting container session, enter:

    . start-blazegraph.sh

Note the IP adress displayed, and using a browser on the host system, access Blazegraph at `http://<IP-address>:9999/blazegraph/` (substituting the noted IP address; e.g. http://192.168.99.100:9999/blazegraph/).


## ResearchSpace

@@@


