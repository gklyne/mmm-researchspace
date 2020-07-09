This note is an attempt to collect summaries of our various attempts to deploy ResearchSpace with MMM data.

See also:

- https://github.com/gklyne/mmm-researchspace/blob/master/NOTES.md

# To try

- Copy global node modules from antheia to vm-seldon...


# List of ResearchSpace deployments attempted

## OxLOD

- Platform: antheia, bare-metal, Centos (6?)
- Uses: RS2.1
- Build from source: yes
- Documentation:
    - https://github.com/natuk/oxlod-plumbing/wiki/ResearchSpace#build-researchspace
- URL: https://antheia-researchspace.oerc.ox.ac.uk/

This installation was completed in 2018 for OxLOD data.

It remains a running example of ResearchSpace, but not with MMM data.

## British Museum demonstrator

- Platform: ?
- Uses: ?
- Build from source: ?
- Documentation: ?
- URL: https://public.researchspace.org/

(I'm mentioning this for completeness)

This is the only known instance of ResearchSPace with the interactive query interface that has been much-liked.  We don't have admin access to view the Metaphactory templates used.


## ResearchSpace 3.4 preview bundle (with demo data)

- Platform: Docker, Centos 7
- Uses: RS3.4
- Build from source: No
- Documentation: 
    - https://github.com/gklyne/mmm-researchspace/tree/master/researchspace-demo
- URL: http://localhost:10214/

This was a straightforward attempt to install and test the ready-to-run ResearchSpace 3.4 installation bundle made available by British Museum.  It includes some demo data.

To date, these bundles have been the only reliably successful way of getting a running ResearchSpace system.


## ResearchSpace 3.4 preview bundle (with MMM data)

- Platform: Docker, Centos 7
- Uses: RS3.4
- Build from source: No
- Documentation: 
    - https://github.com/gklyne/mmm-researchspace/tree/master/researchspace-3.4-mmm
    - https://github.com/gklyne/mmm-researchspace/blob/master/researchspace-3.4-mmm/Dockerfile
- URL: http://localhost:10214/, http://localhost:10214/

This uses the same preview bundle as above, but goes on to load MMM data.

This experiment includes various scripts for loading data into the blazegraph instance that is used by the ResearchSpace system.

The resulting data is not visible to the built-in ResearchSpace functionality because of namespace URI differences, but it is visible through the sparql endpoint provided.

I went on to modify the MMM data to use the namespace URIs expected by ResearchSpace, and was able to view MMM entities through the RS built-in interface.  See: https://github.com/gklyne/mmm-researchspace/blob/master/NOTES.md#use-different-cidoc-crm-namespace-uri-2020-04-28

I then tried digging into the installed filesystem to find where the namespace URIs were specified.  I found the only source code references to the URIs used by ResearchSpace and replaced them with 

See: https://github.com/gklyne/mmm-researchspace/blob/master/NOTES.md#further-investigations-2020-03-27 (these notes are incomplete - I was starting to thrash about here).  Experimentation was becoming very tedious because of the build and startup times involved for each new Docker image created.


## OxLOD build in Docker

- Platform: Docker, Centos 7
- Uses: RS2.1
- Build from source: Yes
- Documentation: 
    - https://github.com/gklyne/mmm-researchspace/tree/master/researchspace
    - https://github.com/natuk/oxlod-plumbing/wiki/ResearchSpace#build-researchspace
- URL: http://localhost:10214/

This is my attempt to use the OxLOD build instructions in a Docker container.

It appeared to work, and at the time I thought it was working, but I now think it suffered the same failures that have been observed with the virtual machine approach tried later.

A problem with the Docker environment was that the final stages of the build could not be run by Dockerfile, and hence saved in the Docker image.  This meant that it was taking several minutes to start running the Docker image, which made experimention meaningful very time-consuming, and only limited experimentation could be conducted in this form.


## Recreate OxLOD build on new virtual machine

- Platform: seldon, OpenStack VM, Centos 7
- Uses: RS2.1
- Build from source: yes
- Documentation: 
    - https://github.com/gklyne/mmm-researchspace/tree/master/researchspace-vm
    - researchspace-openstack-vm-setup-notes.txt (not online because it has passwords)
    - https://github.com/natuk/oxlod-plumbing/wiki/ResearchSpace#build-researchspace
- URL: http://vm-seldon.oerc.ox.ac.uk:10214/

This is my attempt to use the OxLOD build instructions in a persistent virtual machine environment.

The basic build appeared to go well, but the final stage generates numerous errors that seem to all boil down to non-availability of a public repostory (nexus.grapphs.com) on which the build depends.

I was able to get the maven/ivy builds to work with a few tweaks, but there were numerous problems, but there were still problems with the node assets server.  It appears to be a node modules dependency problem, probably caused by the nexus.grapphs.com repository that we can no longer access.

@@TODO: should re-apply the maven/ivy tweaks to get those builds to complete cleanly, then try again to replace the node_modules directories?


## MMM test data on Euterpe

One testing version is running on Euterpe. It was based on replicating Thanasis' instructions and looked like an ok install. It was pointed at MMM triples, but was never really tested and was clearly a bit flaky (It's the one that I've shown you in the past). Currently I can't log into it, though. I don't know why.


# Dead end experiments

## ResearchSpace 3.4 preview bundle with older templates

- Platform: Docker, Centos 7
- Uses: RS3.4, RS3.2(?)
- Build from source: No
- Documentation: 
    - https://github.com/gklyne/mmm-researchspace/tree/master/researchspace-3.2
    - https://github.com/gklyne/mmm-researchspace/blob/master/NOTES.md#using-older-templates-with-the-latest-software
- URL: http://localhost:10214/

This was a dead-end attempt to drop templates used by OxLOD into the ResearchSpace 3.4 preview bundle release.  I documented this as ResearchSPace 3.2 data, but this was before I looked more closely.  It's probably not worth any further attention.


## Summer school early music data

(Included as dead-end because now wiped)

One now wiped was a modified docker instance set up by Iain. That's the one we pointed at the early music data and is the only one I know of with substantially modified templates and non-CIDOC ontologies. (wiped because it was a Summer School machine)
