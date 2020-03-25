# Briefing notes for ResearchSpace investigations

(These rough notes are copied here from various meeting notes, for ease of reference)

# Goals (from 20200121 meeting)
 
- Can we get ResearchSpace up and running with MMM data
- What does it give us?
    - E.g. look at the "25 research questions"; also look modelling group prioritization
    - E.g. search vs browsing 
    - E.g. "network diagram" (Toby wants)
 
- Aim to inform future proposals rather than current project outputs, so the goal here is knowledge about applicability of ResearchSPace rather than a demo-able system.
 
- NOTE: diversity of data sources feeding MMM means that the same information may be described in different ways when coming from different sources.
 
# Questions
 
- Availability of Finland's SPARQL construct queries used for merging?
 - How to get the MMM data (ask David)
    - Use the pipeline
- Where is the experience report on ResearchSpace (e.g. for OxLOD) (Thanasis, via David)
- Where will ResearchSpace be deployed
    - Initial efforts are aimed at using a Docker container, so anywhere
 
 
# Plan outline
 
Feb-2020: ResearchSpace running with (some) MMM data - aim for 25 Feb 2020 for review with Toby

    - stand up software (4d?) - generated updated instructions - try for docker container? - point at finish endpoint. 
    - look at ResearchSpace configuration to work with MMM data (2d)?
    - Updated instructions in OxLOD github wiki: 
        - https://github.com/natuk/oxlod-plumbing/wiki/ResearchSpace
 
Mar 2020: Identify some possibly-useful customizations? (esp UI support)

    - Further ResearchSpace configuration (1d?)
    - load MMM data (representative sample?) (2d?)
    - Preliminary review research questions (1d?)
        - https://docs.google.com/document/d/1nWtKnu67BjFRIcjpgyuIFBdpmhJgJTbcqJN51STH2lc/edit 
        - SPARQL answers in YASGUI links
    - Investigate adding "helper triples"? (locally only)  (to support "semantic query builder") (1d?)
        - ("prove the point, but not the scale")
        - SPARQL fridays participation
        - Look for YASGUI saved queries?
    - Look into query builder??  May be tough (1d?)
 
Apr 2020: Review and plan next steps
   
 
# Links
 
## ResearchSpace installation
 
- ResearchSpace for MMM:
 
    https://docs.google.com/document/d/1sZmFbSKKyy5VRtD5z2sRViYdpwOuklbQfRS0ZV7eJ0k/edit#

- Thanasis' ResearchSpace notes
 
    https://github.com/natuk/oxlod-plumbing/wiki/ResearchSpace

    NOTE: ResearchSpace assumes a separate triple store instance - tested with Blazegraph.  Thanasis may have recorded dead ends
 
    NOTE: recent big code drop from BM (version 3.2; Thnassis worked with older version)

    Notes imply this is ResearchSpace 2.1??
 
- ResearchSpace install for OxLOD

    https://antheia-researchspace.oerc.ox.ac.uk/login

    (Currently don't have account.)

- ResearchSpace at BM with old UI:

    https://public.researchspace.org/resource/Start


## Data access
 
- Aalto (Finland) triple store endpoint:

    http://ldf.fi/mmm-cidoc/sparql
 
- Also:
    - mmm-bibale
    - mmm-sdbm (?)
    - mmm-bodley
 
- Bodleian triple store:

    @@@ 

- Penn triple store:
 
    @@@ 

 
## UI
 
- mappingmanuscriptmigrations.org
 

## Other
 
- euterpe.oerc.ac.uk (David Lewis admin - web server)

- kharites.oerc.ac.uk (triple store) 
 
- The MMM Google Drive is here:

    https://drive.google.com/drive/folders/0B8OzAicQHzwRMlprM1JmUXRUMEU?usp=sharing 
 
- The paper on TEI to RDF is here (forthcoming in GraphSDE conference proceedings):

    https://drive.google.com/open?id=1HVIt622P3SGRDYt6zBzdtd9YOR5DmGMr 
 
- The research questions are documented here:

    https://docs.google.com/spreadsheets/d/1Tdt3dNGkq5aEpC-IXCpxXZeEptnOhI60rVeT_m_mjw4/edit?usp=sharing 
 
 
- https://yasgui.triply.cc/
 
- https://github.com/mapping-manuscript-migrations
 
- path for generating RDF from Bodleian data from manuscript catalogue:
 
    https://github.com/mapping-manuscript-migrations/bodleian-mmm

# Discussions

# 2020-02-25

Note UI is massively changed from earlier work.

- I've posted question about this to the RS gitter channel.  Is the old one gone forever? No response.

- https://researchspace.linkedmusic.org/login

    (login admin/admin - then see links to tutorials.  Password changed now.)

- http://localhost:10214/resource/?action=edit&uri=Template%3Ahttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23Resource


## Working on ResearchSpace 3.4 preview 

https://public.researchspace.org/resource/Start - has OLD UI (currently)

DONE: install updated start.sh (with enlarged Java memory) in Docker file for new bundle

@@TODO: forward-port old UI stuff to new ResearchSpace implementation

Notes: 

- Thanassis' notes:

    https://github.com/natuk/oxlod-plumbing/wiki/ResearchSpace

- ResearchSpace platform repository: 

    https://github.com/researchspace/researchspace

### Notes by Thanassis say:

> Templates are stored in the metaphacts directory data/templates. These are the ones that admin users modify in the UI. By default they are overwritten by the ResearchSpace templates in the apps/researchspace/data/templates directory every time ResearchSpace starts. This means that any modifications during runtime are then lost as the ResearchSpace templates are enforced again if the system is restarted.

The new software release uses separate directories:

    apps/<app-id>/data/templates/

and

    runtime-data/data/templates/(?)   (@@check this)

for preloaded and dynamically created template data.  I'm not currently sure what effect this has on restart in a running system, but if the container is restarted then any runtime changes are lost.  My strategy will be to preload any re-usable configuration in the container, and maybe to move runtime-data to a separate volume that is preserved across container restarts.






 