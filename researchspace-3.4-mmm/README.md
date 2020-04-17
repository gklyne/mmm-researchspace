# ResearchSpace 3.4 with MMM data

This directory is being used for setting up a Docker container with ResearchSpace 3.4 preview installation loaded with MMM data.

The source for the software is linked from https://github.com/researchspace/researchspace#demo.  I.e.

https://github.com/researchspace/researchspace/releases/download/v3.4.0-preview/researchspace-3.4-preview-bundle.zip

The source for the data is https://zenodo.org/record/3667486

The source for additional schema not in the Zenodo bundle is at https://github.com/mapping-manuscript-migrations/mmm-fuseki

# Running this container

NOTE: I'm running a Docker instance with 6Gb of RAM allocated.  The ResearchSpace server is run with access to up to 4Gb of heap space.  This may not work too well on a host machine with limited RAM.  I would guess that 8Gb is a minimum RAM required, with 16Gb preferred.

If you have Docker installed, to start ResearchSpace:

1.  Use this `docker run` command:

        docker run -it --publish=10214:10214 --publish=3000:3000 \
               gklyne/researchspace-mmm

    (It may take a while to start first time as Docker downloads the container from DockerHub.)

2.  At the resulting command prompt, enter:

        . start-researchspace.sh

3.  Wait a while - it may take 30-60 seconds or so for ResearchSpace to get started.

4.  On the host computer, fire up a browser and go to:

        http://localhost:10214

5.  Log in using username `admin`, password `admin`.  (Don't use this setup on a publicly accessible network!)

6.  Browse to 

        http://localhost:10214/sparql

    and try entering a SPARQL query; e.g.

        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX crm: <http://www.cidoc-crm.org/cidoc-crm/>
        SELECT * WHERE {
          ?sub rdf:type <http://erlangen-crm.org/current/E21_Person> .
        } 
        LIMIT 100

Here is an example startup sequence:

```
$ docker run -it --publish=10214:10214 --publish=3000:3000 gklyne/researchspace-mmm

[root@970b6e5603a5 /]# ls
bin  home   lost+found  mmm_data.zip  proc                  root  srv             tmp
dev  lib    media   mnt       researchspace-3.4-preview-bundle      run   start-researchspace.sh  usr
etc  lib64  mmm_data    opt       researchspace-3.4-preview-bundle.zip  sbin  sys             var
[root@970b6e5603a5 /]# . start-researchspace.sh
Starting ResearchSpace...

   :

2020-04-17 13:45:05.108:INFO:oejsh.ContextHandler:main: Started o.e.j.w.WebAppContext@3c989952{ROOT,/,file:///researchspace-3.4-preview-bundle/jetty-distribution/webapps/ROOT/,AVAILABLE}{/ROOT}
2020-04-17 13:45:05.194:INFO:oejs.AbstractConnector:main: Started ServerConnector@2d896dae{HTTP/1.1,[http/1.1]}{0.0.0.0:10214}
2020-04-17 13:45:05.195:INFO:oejs.Server:main: Started @52905ms
```




