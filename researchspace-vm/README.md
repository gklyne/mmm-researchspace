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

    sudo su - researchspace

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

See: https://github.com/natuk/oxlod-plumbing/wiki/ResearchSpace

@@@

Various files changed to get base system running:

commit 5f03133496544b88a34f1fdfd82298520763fb58
Author: Graham Klyne <graham.klyne@oerc.ox.ac.uk>
Date:   Fri Jun 5 12:44:42 2020 +0000

Files changed in first working ResearchSpace build (still has css-loader problems)

        metaphactory/web/.npmrc
        metaphactory/web/.yarnrc
        metaphactory/web/package.json
        metaphactory/web/saved.npmrc
        metaphactory/web/saved.package.json
        metaphactory/web/saved.yarn.lock
        metaphactory/web/saved.yarnrc
        metaphactory/web/yarn.lock
        package-lock.json
        project/build.properties
        project/plugins.sbt.orig
        project/repositories
        project/repositories.unused
        project/webpack/.npmrc
        project/webpack/.yarnrc
        project/webpack/package.json
        project/webpack/saved.npmrc
        project/webpack/saved.package.json
        project/webpack/saved.yarn.lock
        project/webpack/saved.yarnrc
        project/webpack/yarn.lock
        researchspace/web/.npmrc
        researchspace/web/.yarnrc
        researchspace/web/package.json
        researchspace/web/saved.npmrc
        researchspace/web/saved.package.json
        researchspace/web/saved.yarn.lock
        researchspace/web/saved.yarnrc
        researchspace/web/yarn.lock
        yarn.lock

Also changed for browser access to assets:

        project/PlatformBuildPlugin.scala
        project/webpack/package.json
        project/webpack/server.js
        project/webpack/webpack.dev.config.js
        project/webpack/webpack.dll.dev.js
        project/webpack/yarn.lock

Install OS packages:

    libpng-devel (libpng-dev on Debian)
    autoconf

References to repository that no longer exist:

    https://nexus.grapphs.com/repository/npm/

Three projects had to change .yarnrc and .npmrc to remove repository reference, 
then re-run yarn on each:

    metaphactory/web
    researchspace/web
    project/webpack

Installed css-loader fails.  Use npm to install, select version @1.0.1

    npm install css-loader@1.0.1

Still not working.

Tried version of css-loader installed on antheia.  Still just errors.


## STATUS

[2020-05-06]:

1. The Blazegraph install script is [install-blazegraph.sh](./install-blazegraph.sh).
2. The ResearchSpace build script is [build-researchspace.sh](./build-researchspace.sh).


## Clone researchspace from antheia

(This approach has been used in placed of the pevious ResearchSpace build instructions, beyond the initial system setup.  These notes copied from private notes on laptop at 'researchspace-openstack-vm-setup-notes'.  I think I also did someting similar later for 'node_modules'.)

1. Create tar archives of /home/researchspace, /home/blazegraph on antheia, and copy to remote-accessible directory.  e.g.

        tar czvf antheia-home-researchspace.tgz /home/researchspace
        mv antheia-home-researchspace.tgz graham/
        chown graham: graham/antheia-*

2. On target system, copy archives from antheia; e.g.

        cd /home/researchspace/antheia
        scp -i /home/researchspace/.ssh/id_rsa_antheia_graham graham@antheia.oerc.ox.ac.uk:antheia-home=researchspace.tgz .
        tar xfvz antheia-home=researchspace.tgz

3. Repeat for /home/blazegraph and /data/blazegraph

    NOTE: the instance of Blazegraph running on antheia is from `/home/blazegraph`, and the blazegraph data used is in `/data/blazegraph`

4. Created scripts in /home/researchspace/antheia for starting Blazegraph, loading MMM data and starting ResearchSpace

It seems to work, but after loading the MMM data, I can't see it in SPARQL queries, so I'm not sure what's happening here.  (Later:  I think this was to do with the Blazegraph "namespace" acessed.)


