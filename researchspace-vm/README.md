This directory contains files for installing Blazegraph and building researchspace on a CentOS virtual machine (or any system) using source pulled from GitHub.

The setupscript is based on Docker files from directories [blazegraph](../blazegraph) and [researchspace](../researchspace).

The build process is based on these notes:

- https://github.com/natuk/oxlod-plumbing/wiki/ResearchSpace

Script files in this directory should be copied to a working directory on the target system, and run from that directory.

## Preliminaries

Before starting, on the target machine:

Create new user using "useradd"; e.g. 

    useradd researchspace

Add new user to group wheel (to allow use of sudo command); e.g.

    usermod researchspace -a -G wheel

Set password for new user (will be needed for sudo):

    passwd researchspace

Switch to new user:

    su - researchspace

Copy files in this github directory to the researchspace user home directory

    cd $HOME
    mkdir github
    cd github
    git clone https://github.com/gklyne/mmm-researchspace.git
    cd $HOME
    cp ./github/mmm-researchspace/researchspace-vm/* .


## Install Blazegraph

    . install-blazegraph.sh

Test run:

    . start-blazegraph


## Build ResearchSpace






## STATUS

[2020-05-06]:

1. The Blazegraph install script is [install-blazegraph.sh](./install-blazegraph.sh).
2. The ResearchSpace build script is [build-researchspace.sh](./build-researchspace.sh).

