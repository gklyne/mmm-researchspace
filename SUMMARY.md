# Summary of activities in MMM/ResearchSPace investigations

## Researchspace deployments and experiments

A large portion of the activity was addressed to trying out different ResearchSpace deployments.  A major update to ResearchSpace around the start of this activity meant that some of the prior assumptions about it, based on the deployment created for OxLOD data, were called into question, particularly with respect to it being ontology-agnostic.  The problems were compounded by disappearance of an intermiedfuate software repository that was essential to creating the OxLOPD deployment of ResearchSpace.

Early efforts were directed to using Docker, but the transience of Docker instances coupled with the need for significant interactive setup meant that this turned out to be not practical.  Eventually, we used a virtual machine environment with substantial manual tweaks beyond the initial deployment - so this isn't really a repeatable deployment.

In the end, the later experiments were performed using a clone of the OxLOD deployment.

See:

- [Summary of deployments tried](./Deployment-options-review.md).
- [More detailed notes about deployments](./NOTES.md).  These are not particularly coherent, being more like a running notebook of things tried and ideas considered, but there may be details here that are not recorded elsewhere.
- [Preliminaries for using Docker on MacOS](./Docker-setup-MacOS-preliminaries.md).
- [Preliminaries for VM deployment of ResearchSpace](./researchspace-vm/README.md)


## Load MMM data into ResearchSpace

Initial experiments loaded unmodified MMM data into researchspace, but due to a different namespace URI this wasn't accessed by the research displays.  A modified verson of the data was loaded, and could be presented by researchspace.  See the `researchspace-3.4-mmm` subdirectory.  I was unable to modify the Dockerized Researchspace deployment to recognize the MMM namespace URIs, hence...

In subsequent experiments, a persistent virtual machine running a clone of the OxLOD ResearchSpace deployment was used.  In this case, I was able to update the namespace URIs, and more, so that unmodified MMM data could be accessed and displayed by ResearchSpace.  Files and notes are in the `researchspace-vm` subdirectory.  (Some details are buried in the command history files.)


## Modify MMM templates to support MMM research questions

Initially, the Actor display template was modified as an initial proof of concept.  See [ActorSummary.template.edits](./ActorSummary.template.edits).

Then we returned to the ResearchSpace research questions.  An analysis of the kind of queries needed to access these was distilled from existing MMM documents, and summarized in [Nodes.md](./NOTES.md) at the section "Looking at research questions (2020-07-07)" and subsequently.

Works by author... added to Actor page

Who collects... added link to Actor page, plus new page template, parameterized by author (Actor) ref.

Other MSS in collection... link on who collects page, parameterized by author and collector (Actor) refs.

Current/last known location of manuscript...

Landing page... (tried to modify OxLOD search; didn't work, so created new simplified starting page with links.)

List of people page...

List of works page...

Modified queries so that incremental search in table works...


## Thoughts about hypermedia-driven data exploration

See: nodes.md

- Reflections on addressing research questions (2020-07-09)
- 


