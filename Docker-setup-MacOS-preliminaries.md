
## MacOS preliminaries

These instructions are based on the "Docker toolbox" kit (not the more recent "Docker desktop", which requires a newer version of MacOS than I was running at the time, and handles virtualization and networking somewhat differently).  Updated recipes that work with the more recent versions of Docker are in various subdirectories.

1. Install VirtualBox if not already installed (@@details?)

2. Install Docker toolbox if not already installed (download and run https://github.com/docker/toolbox/releases/download/v19.03.1/DockerToolbox-19.03.1.pkg)

2. Run Applications > Docker > "Docker Quickstaret Terminal" (e.g. from spotlight search) to create a new terminal session with access to a running docker daemon.

3. Subsequenet commands are entered in the new terminal window.  (Note: the Docker daemon is not accessible from other terminal windows.)

NOTE: in order for the ResearchSpace compilation to proceed, I have increase the VirtualBox memory allocation for docker-machine by editing `Applications/docker/Docker Quickstart Terminal.app`, content `Contents/Resources/cripts/start.sh`, changing:

    --virtualbox-memory 2048

to:

    --virtualbox-memory 4096

That didn't work once the docker 'default' configuration has been created. Also try:

1. stop all docker virtualmachines
2. in a terminal window, type `virtualbox`
3. select the `default` VM, right-click on it and select `close` to power it off
4. in the `settings` > `system` tab, cange the memory from 2048 to 4096 Mb
5. re-run `Docker Quickstart Terminal.app`


## Blazegraph

    cd ./blazegraph
    . build-blazegraph-image.sh
    . run-blazegraph-container.sh

Then, in the resulting container session, enter:

    . start-blazegraph.sh

Note the IP adress displayed, and using a browser on the host system, access Blazegraph at `http://<IP-address>:9999/blazegraph/` (substituting the noted IP address; e.g. http://192.168.99.100:9999/blazegraph/).


## ResearchSpace

@@@


