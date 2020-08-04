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

Initial experiments loaded unmodified MMM data into ResearchSpace, but due to a different namespace URI this wasn't accessed by the ResearchSpace displays.  A modified verson of the data was loaded, and could be presented by ResearchSpace.  See the `researchspace-3.4-mmm` subdirectory.  I was unable to modify the Dockerized ResearchSpace deployment to recognize the MMM namespace URIs, hence...

In subsequent experiments, a persistent virtual machine running a clone of the OxLOD ResearchSpace deployment was used.  In this case, I was able to update the namespace URIs, and more, so that unmodified MMM data could be accessed and displayed by ResearchSpace.  Files and notes are in the `researchspace-vm` subdirectory.  (Some details are buried in the command history files.)


## Modify MMM templates to support MMM research questions

### Actor display page

Initially, minor changes were made to the Actor display template as a proof of concept.  See [ActorSummary.template.edits](./ActorSummary.template.edits).

A more substantive modification was to include a list of authored works on the Actor page, as a new tab alongside "Key facts", "Links from here" and "Links to here".  This involves a sunstantive MMM-specific query of the underlying data.  E.g. see [Llull, Ramon, 1232?-1316](http://vm-seldon.oerc.ox.ac.uk:10214/resource/?uri=http%3A%2F%2Fldf.fi%2Fmmm%2Factor%2Fbodley_person_120696927).


### New page: who collects works by author

Next we returned to the ResearchSpace research questions.  An analysis of the kind of queries needed to access these was distilled from existing MMM documents, and summarized in [Nodes.md](./NOTES.md) at the section "Looking at research questions (2020-07-07)" and subsequently.  @@ref new Google doc@@

Thinking about these led to an idea that many questions could be addressed through a composition of higher level query elements.  An example of such an element might be "Who collects works by a given author?".

This query was implemented as a separate pagetemplate, and a link to this added to the existing ResearchSpace Actor display page.  e.g. see [Who collects "Llull, Ramon, 1232?-1316" ? ](http://vm-seldon.oerc.ox.ac.uk:10214/resource/who_collects?actor=http://ldf.fi/mmm/actor/bodley_person_120696927&actorName=%22Llull,%20Ramon,%201232?-1316%22).

This page uses URL query parameters to indicate whose works are of interest.


### New page: other manuscripts in collection

A next question arises: how might composition of investigatove elements be achieved.  Attempting to use a basic affordance of the World Wide Web with which most users would be familiar, we explored the idea of using hyperlink-following to represent composition.  So an exploration of the data becomes a process of seeking out a path though hyperlinked data, where each step (link) of the path is a refining some existing dataset, or accessing some associated data elements.

As an example of this idea, we constructed a new querty for "What manuscripts of works by a given author are in a given collection" (where a collection here is identified by its owner, and may be current or historic).  The composed query is represented by links from the "who collects works by author" page, and clicking on one of these links presents a new page which lists manuscripts and works by a given author in a given collection.  E.g. see [What manuscripts by Llull, Ramon, 1232?-1316 in collection of Canonici, Matteo Luigi, 1727-1805](http://vm-seldon.oerc.ox.ac.uk:10214/resource/mss_by_collection_author?actor=http://ldf.fi/mmm/actor/bodley_person_120696927&collector=http://ldf.fi/mmm/actor/bodley_person_2384880).

This query has an ad-hoc implementation to illustrate how the composition might appear - the implenation itself is not a generic composition.  Some ideas about how generic compoisition might be implemented are discussed in [Thoughts for using Solid-based working sets](https://github.com/gklyne/mmm-researchspace/blob/master/NOTES.md#thoughts-for-using-solid-based-working-sets).

Finally, we demonstrated how the above query could be quickly modified by someone with some technical knowledge of ResearchSpace, SPARQL and HTML to include additional information.  In our case, we added the curent location to the list of manuscripts in a collection - this is illustrated in the [demonstration video](http://annalist.net/media/researchspace_mmm.mp4).


### New landing page

We attem,pted to make these experiments more accessible by modifying an existing search page, but those experiements did not work for us.

So instead, a completely new [landing page](http://vm-seldon.oerc.ox.ac.uk:10214/resource/:MMM_landing_page) was created, with links to [list of known people](http://vm-seldon.oerc.ox.ac.uk:10214/resource/list_people) and [list of known works(http://vm-seldon.oerc.ox.ac.uk:10214/resource/list_works)] pages.


### Incremental results filter

We noted that the queries used in page templates are also used to perform incremental search of selected entities.  For example, on the [list of known people](http://vm-seldon.oerc.ox.ac.uk:10214/resource/list_people) page, typing "Llul" into the "Filter Results" box results in the >22K results being whittled down to just 2.

This incremental search is based on all values retiurned by a query, even if those values are not explicitly displayed.  By adding the values of `skos:prefLabel` properties to the search results, the filters would behave in a reasonably intuitive fashion.


## Thoughts about hypermedia-driven data exploration

See: [NOTES.md](./NOTES.md)

[Reflections on addressing research questions (2020-07-09)](https://github.com/gklyne/mmm-researchspace/blob/master/NOTES.md#reflections-on-addressing-research-questions-2020-07-09) starts to consider the composable query elements that might be required to address the research questions.  It is distilled from existing MMM work on queries to support re=search questions, in a way that aims to highlight what the distinct query elements might be.

- [Thoughts for using Solid-based working sets](https://github.com/gklyne/mmm-researchspace/blob/master/NOTES.md#thoughts-for-using-solid-based-working-sets) explores a possible model for composing query results using hyperlinks and Solid pods for working sets.

