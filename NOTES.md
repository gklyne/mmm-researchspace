These are my very rough notes about configuring ResearchSpace/metaphacts 3.4 release with custom UI templates.


# Investigating ResearchSpace configuration

## 3 interfaces?

I'm confused again.  There appear to be 3 different interfaces:

https://researchspace.linkedmusic.org/resource/Help:Start, which announces as metaphactory 2.0

https://public.researchspace.org/ ResearchSpace interactive faceted browse/search (old RS UI?)

Latest version running locally: completely new UI

Tried examining network traffic from browser, but this doesn't help.  It appears that the template expansion logic is all in the server.  (@ainlq made reference to a java implementation of handlebars).

See also:

http://localhost:10214/resource/Help:TemplateAndApplicationPages

http://localhost:10214/resource/Help:BackendTemplating - lots of detail here

http://localhost:10214/resource/Help:SemanticSearch


## Locating the templates used

Understanding dawns...

The packaged ResearchSpace preview/demo bundle has apps "metaphacts-platform" and "researchspace" bundled in the jar file.  These include namespace prefix definitions, and more.

But the resources provided by these packages can be (or must be?) overridden by a custom application by placing or replacing files in `/researchspace-3.4-preview-demo-bundle/apps/custom-app-id/data/templates`, such as `http%3A%2F%2Fwww.researchspace.org%2Fresource%2FProjectDashboard.html` (note the filename here is the encoded URL of the page resource).

The source for these files can be found in GitHub at, e.g.:

- https://github.com/researchspace/researchspace/tree/master/metaphacts-platform
- https://github.com/researchspace/researchspace/tree/master/researchspace/app

The source for the "custom" demo application is accessible in the preview demo bundle, at:

- `/researchspace-3.4-preview-demo-bundle/apps/custom-app-id/data/templates`, etc.

The initial home page (after login) is (apparently) configured by `apps/custom-app-id/config/global.prop` as:

- http://localhost:10214/resource/rsp:Start

`rsp`: prefix expands as `http://www.researchspace.org/resource/` (see: https://github.com/researchspace/researchspace/blob/master/researchspace/app/config/namespaces.prop)

`Default:` prefix expends as `http%3A%2F%2Flocalhost%3A10214%2Fresource%2F` in a filename in the `templates` directory; e.g.

- http%3A%2F%2Flocalhost%3A10214%2Fresource%2Faltstarttest.html

Also note that any edits made in the running system are applied to the `runtime-data/data/templates/` directory, and would be lost on restarting the Docker container (though it may be possible to pre-populate the runtime-data directories via Dockerfile).


# Using older templates with the latest software

NOTE: latest software bundle was linked from https://github.com/researchspace/researchspace#demo:

- https://github.com/researchspace/researchspace/releases/download/v3.4.0-preview/researchspace-3.4-preview-demo-bundle.zip
- https://github.com/researchspace/researchspace/releases/download/v3.4.0-preview/researchspace-3.4-preview-bundle.zip


## Accessing the 3.2 release:

```
$ pwd
/Users/graham/workspace/github/gklyne/researchspace

$ git remote -v
origin  git@github.com:researchspace/researchspace.git (fetch)
origin  git@github.com:researchspace/researchspace.git (push)

$ git status
HEAD detached at 0b7668e
nothing to commit, working directory clean

$ git log
commit 0b7668eb9e1e1a9f606bbaae4d7e2ab78ab5f68a
Author: Artem Kozlov <artem@rem.sh>
Date:   Thu Oct 31 10:53:42 2019 +0200

    Release 3.2.0.

commit 76a238ee05af13bbb652484b41d26f5f86ab11e9
Author: Diana Tanase <dtanase@britishmuseum.org>
Date:   Tue Nov 27 15:02:19 2018 +0000

    Updated the location of the blazegraph docker image.

   :

```

## Further investigations (2020-03-23)

It looks as if the start page URI is hard-wired into the underlying platform: `rsp:Start` maps to "http://www.researchspace.org/resource/Start".

In the preview demo bundle, this is mapped to file `/researchspace-3.2/researchspace-3.4-preview-demo-bundle/apps/custom-app-id/data/templates/http%3A%2F%2Fwww.researchspace.org%2Fresource%2FStart.html`.  Removing just this file results in the following message after login:

```
It seems that no entity with IRI "http://www.researchspace.org/resource/Start" in any subject, predicate or object position is known in the knowledge graph. Also no static application page with this identifier can be found. 
```

Reinstating the one file allows the demo bundle to start as expected.


## Further investigations (2020-03-25)

Creating scripts to create docker file with V3.4 software (using ZIP file bundle provided by BM - see links above) and older application template data from Research Repo in Github (as referenced by Thanassis' instructions), with modified `Start` resource.

The 3.2 page outline structure is still based on new ResearchSpace UI.  I'm struggling to find the older templates.  I need to log in to a running system, but can't do so with sufficient privileges.

NEXT STEPS:  
- ask about login for https://antheia-researchspace.oerc.ox.ac.uk/
- return to Thanassis' version and look at the start page source, and try to replicate that structure in the new container...
- Try previous activity with commit from end of 2018: 76a238ee05af13bbb652484b41d26f5f86ab11e9.
    - https://github.com/researchspace/researchspace/commit/76a238ee05af13bbb652484b41d26f5f86ab11e9


## Further investigations (2020-03-26)

Created new subdirectory for ResearchSpace 2.1, which appears to be the instance that Thanassis installed.  Uses 3.4 software with 2.1 data.  Initially get missing resource error:  it appears that a key namespace URI has changed.

See:

- metaphactory/core/src/main/resources/com/metaphacts/ui/templates/header.hbs
- metaphactory/web/src/main/components/ui/page-loader.ts

Files on target system:

- 

NEXT STEPS:
- track down references to resource/Start page; try to switch namespace URI used
- return to Thanassis' version and look at the start page source, and try to replicate that structure in the new container...


## Further investigations (2020-03-27)

Initial request to "/" returns redirect to "/resource/Start".  It's not clear if this is hard-wired in the code, or somewhere in the configuration.

The request to "/resource/Start" is served with data which might come from 
- metaphactory/core/src/main/resources/com/metaphacts/ui/templates/main.hbs
- apps/custom-app-id/config/page-layout/main.hbs
    But changing the content of that file in the Docker build doesn't seem to change the response served. I conclude that the file used is hard-wired into the researchspace deployment bundle.  It contains the following:

```
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="version" content="develop-build" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <!-- the following header makes IE select latest document mode -->
        <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
        <title>ResearchSpace</title>
<link href="/assets/no_auth/basic-styles.css" rel="stylesheet" title="Default Style">

        <script defer type='text/javascript' src='/assets/no_auth/dll.vendor-75ac12437e453d766d67.js'></script>
        <script defer type='text/javascript' src='/assets/app-25d4577ab1ecd7f9414e-bundle.js'></script>
    </head>
    <body>
      <div id="application"></div>
    </body>
</html>
```

I assume that the key element here is `<div id="application"></div>`

- The `<div id="application"></div>` is populated with stuff that appears to come from app-25d4577ab1ecd7f9414e-bundle.js:

```
<div><nav role="navigation" class="metaphacts-header-navbar navbar navbar-default navbar-fixed-top"><div class="container-fluid"><div class="navbar-header">
<a href="/" style="line-height: 2;" class="navbar-brand">
            ResearchSpace Platform
</a>
 :
```

which is in turn referenced by jetty-distribution/webapps/ROOT/assets/bundles-manifest.json, thus:

```
{
  :
  "page-renderer": {
    "js": "/assets/page-renderer-bundle.js"
  },
  "app": {
    "js": "/assets/app-25d4577ab1ecd7f9414e-bundle.js"
  }
}
```

So it looks like this much is baked into the ResearchSpace preview bundle.  The system appears to request atemplate for a resource named: http%3A%2F%2Fwww.researchspace.org%2Fresource%2FStart, which responds with a response indicating it couldn't be found.


## Trying to get data loaded (2020-04-15/16)

Subdirectory researchspace-3.4-mmm

https://github.com/researchspace/researchspace/blob/master/README.md#building-war-artefact (not immediately relevant)
ls "/"
https://stackoverflow.com/questions/37796254/loading-triples-into-blazegraph-using-the-bulk-data-loader

https://github.com/natuk/oxlod-plumbing/wiki/Bodleian-MMM

https://github.com/natuk/oxlod-plumbing/wiki/Bodleian-MMM#endpoint

http://localhost:10214/blazegraph/

http://localhost:10214/sparql/

http://localhost:10214/sparql/rsp:Start


http://localhost:10214/resource/Help:Start ** lots of good info here **


Default BlazeGraph "namespace" used by ResearchSpace appears to be "kb".

See web.xml:
```
  <context-param>
   <description>The default bigdata namespace of for the triple or quad store
   instance to be exposed.</description>
   <param-name>namespace</param-name>
   <param-value>kb</param-value>
  </context-param>
```

Am now getting data into BlazeGraph:  see DockerFile.

Data now shows up in ResearchSpace sparql queries, but appears to be invisible to researchspace-specific views.


## Use different CIDOC CRM namespace URI (2020-04-28)

As an experiment, I've taken a copy of the MMM data (mainly from the Zenodo published dataset [1], but some schema files directly from GitHub Fuseki recipe [2]).  (There's a GitHub issue [3] about this.)

[1] https://zenodo.org/record/3667486
[2] https://github.com/mapping-manuscript-migrations/mmm-fuseki/tree/master/schema
[3] https://github.com/mapping-manuscript-migrations/mmm-fuseki/issues/1

The source files have been edited to replkace all prefix definition references to "http://erlangen-crm.org/current/" with "http://www.cidoc-crm.org/cidoc-crm/"; e.g.

    # @prefix ecrm: <http://erlangen-crm.org/current/> .
    @prefix crm: <http://www.cidoc-crm.org/cidoc-crm/> .
    @prefix ecrm: <http://www.cidoc-crm.org/cidoc-crm/> .

The data is then loaded into a ResearchSpace instance in a Docker container using the following scripts:

- https://github.com/gklyne/mmm-researchspace/blob/master/researchspace-3.4-mmm/make_mmm_data_zip.sh
- https://github.com/gklyne/mmm-researchspace/blob/master/researchspace-3.4-mmm/build-researchspace-image.sh

The resulting Docker image is pushed to DockerHub as `gklyne/mmm-researchspace`.

To run the image:

    docker run -it --publish=10214:10214 --publish=3000:3000 gklyne/researchspace-mmm

Then at the interactive prompt for the running system:

    . start-researchspace.sh

(Takes about 40 seconds to start on my system)

To explore the contents in ResearchSpace, I start with a simple SPARQL query.  Browse to http://localhost:10214/, login with user:admin, password:admin, ythen browse to http://localhost:10214/sparql and execute this query:

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX crm: <http://www.cidoc-crm.org/cidoc-crm/>
SELECT * WHERE { 
    GRAPH ?graph {
        ?subject rdf:type crm:E21_Person .
  }
 } LIMIT 1000
```

Click on one of the results, and drag the heading item into the Clipboard area of the ResearchSpace Clipboard window.

From the resulting Clipboard entry, click on "Resource details" in the corresponding dropdown.  The next stage may take a while.  It appears that the ResearchSpace interface is present and doing (some of) what it should, but it's really not clear how to navigate it, and on my system it appears to be *very* slow.  The slowness be because the VM really needs more memory for the amount of data loaded (Docker is apparemtly using 11.5Gb on my laptop).  Maybe it's better to load less data for experimentation?


## Next steps (discussed 2020-04-28)

NOTE: Moved to [TODO.md](./TODO.md) - the following may be out of date, and should be removed in due course.

Lacking sufficient knowledge to create a preconfigured container instance ResearchSpace 3 preview bundle, I plan to revert to experiments using ResearchSpace 2.1 (the version that Thanasis deployed for OxLOD).  Earlier experiments have shown we can get it running using Thanasis' recipe, but that the system thus deployed isn't really suitable for containerization (due to the transient nature of containers: they reset each time they are run).

To get a persistent deployment, we propose to use a full virtual machine deployment, intended to be available for a short period so that MMM project members can evaluate its affordances.  Based on what we currently know, this approach seems to offer the least uncertainty in terms of what needs to be done.

Thus:

1. Create new CentOS 7 (or 8?) VM on OeRC-based infrastructure, and request public access for ports needed to view ResearchSpace.

    - NOTE: should probably ensure that Kevin has access to Seldon/Trantor environment, and a few recipes for running up VMs, for whenmy contract expires.  Will need a public/private key pair.

2. Ask Thanasis what he found out about configuring RS semantic search.  (Apparently requires some helper triples to be added?)

3. Install RS 2.1 on VM environment.  Script as much as possible.

4. Load (unmodified) MMM data into RS 2.1

5. Configure semantic search over MMM data

    - Once basic technical deployment is done, liaise with David L about domin specifics that are applicable to semantic search over MMM data.

6. Stretch goal:  try to repeat the above for RS 3.4.

    - Ask if there are instructions or commands for building the preview bundle from the source repo.


# Looking at research questions (2020-07-07)

Research questions: 
https://docs.google.com/spreadsheets/d/1Tdt3dNGkq5aEpC-IXCpxXZeEptnOhI60rVeT_m_mjw4

Research Question B3:  "Who collects manuscripts with texts by Ramon Llul?"

1. Place "who collects" link on Actor page, parameterized by actor id
Question: how can parameter be passed to template?
2. Create new template for "who collects" Ramon Llul
3. Modify template for "who collects" to be parameterized by actor Id

See: http://vm-seldon.oerc.ox.ac.uk:10214/resource/Help:BackendTemplating
- urlParam Helper
- generate link with appropriate query parameter?

See:
- ActorSummary.template.edits
- who_collects.html

Example:
- http://vm-seldon.oerc.ox.ac.uk:10214/resource/?uri=http%3A%2F%2Fldf.fi%2Fmmm%2Factor%2Fbodley_person_120696927
    (Note 'Who collects "Llull, Ramon, 1232?-1316"?' link)
- http://vm-seldon.oerc.ox.ac.uk:10214/resource/who_collects?actor=http://ldf.fi/mmm/actor/bodley_person_120696927&actorName=%22Llull,%20Ramon,%201232?-1316%22


# Reflections on addressing research questions (2020-07-09)

Research questions: 
https://docs.google.com/spreadsheets/d/1Tdt3dNGkq5aEpC-IXCpxXZeEptnOhI60rVeT_m_mjw4

The previous activity started to demonstrate how ResearchSpace can be used to create custom information pages.  Note that a key difference from things tried previosuly is the introduction of a new "application" page that is parameterized using URI query elements.  This avoids the need to depend on the built-in ResearchSpace dispatching mechganisms.

What we now wish to explore is using a hyperlinked set of such pages to allow a user to explore various research questions.  Ideally each query element will be handled by a single application page (like the "who collects" page), in such a way that different queries can be composed by following links (combined with ResearchSpace built-in semantic table filter capabilities).

So far, the "who collects" logic is linked directly into the Actor Summary template.  This is likely to become cumbersome in due course.  I propose that the embedded logic that generates the parameterized link is moved to a separate "Explore actor" page.  Similar, possibly, for works, manuscripts, places, etc.  But I'm not sure how to handle composites - I propose to ignore that concern until a real case arises from examination of the research questions.

Currently, the exploration page is parameterized by a single Actor URI:  maybe this should be extended to allow multiple actors (queries effectively becoming list monads?).  I'm not sure how do-able this is (i.e. can we collect all selected matches and pass them forward?).  For now, stick with the simpler single-instance case.

Survey of questions; for each, I have tried to identify query elements that would need to be composed to achieve the desired results:

A1:
- (a) manuscripts by (production event) date
- (b) manuscripts by (production event) place (Europe)

A2:
- (a) manuscripts by surviving?
- (b) manuscripts by language content
- (c) manuscripts by place (Castile)
- (d) manuscripts by "produced for abbey or convent"
- (e) manuscripts by collector
- (f) collectors by nationality
- (g) collectors by is-private (or is-person?)
- (h) manuscripts by current owner (collector?)
- (i) collector by is-institution

A3:
- (a) collectors by nationality
- (b) manuscripts by acquisition date by collector (composite key)   
- (c) current location by manuscript

B1:
- (a) manuscripts by author of work
- (b) manuscripts by purchase (acquisition?) date

B2: (there is no B2)

B3:
- (a) manuscript by author of work
- (b) collector by manuscript

B4:
- (a) manuscripts by author of work
- (This case challenges the composition capabilities: given two authors, fimd manuscripts that contain works by both authors.)

B5:
- (a) manuscript of works by "a medieval author"
- (b) work by manuscript
- (This case additionally requires finding the maximum count of any result value.)

C1: (none)

C2:
- (a) manuscripts by collector (or "asscociated with?")
- (b) manuscripts by "thirteenth-century bible"
- (c) manuscripts by "historiated initials" 

F1:
- (a) manuscripts by collection (or by owner?)
- (b) manuscripts by "specific physical feature" (e.g. enluminés)

F3:
- (a) actors (and their roles) by (association with) collection

F4:
- (a) manuscripts by collection (or by owner?)
- (b) manuscripts by work
- (c) works by subject category 

F5:
- (a) manuscripts by collection (or by owner?)
- (b) places by (production of) manuscript
- (c) dates by (production of) manuscript

F7:
- (a) manuscripts by collection (or by owner?)
- (b) events (provenance and production) by manuscript

F8:
- (a) manuscripts by (no) current location;  last observed/known location as a kind of proxy?

F9:  ?

G1:
- (a) manuscripts by work
- (b) manuscripts by "specific physical feature" (e.g. enluminés)

G2:
- (a) all works
- (b) manuscripts by work
- (plus some composition filtering to exclude works with >1 manuscript)

G4:
- (a) People by life-dates
- (b) Works by person
- (c) Works by language
- (d) People by association with work
- (e) Life-dates by person

G5:
- (a) manuscripts by work
- (b) production date+place by manuscript

??:
- (a) manuscripts by place of production event

??:
- (a) manuscripts by place of production event and date range (composite key)

??:
- (a) manuscripts by (previous/sometime) owner
- (b) manuscripts by current location/owner

??:
- (a) manuscripts by work
- (b) filter manuscripts by text in title
- (c) number of folios by manuscript
- (plus some counting/computation)

??:
- (a) manuscipts by seller
- (b) owners (actors) by manuscript
- (c) location by actor
- (d) "kind of manuscript and earlier history" by manuscript

??:
- (a) works by language
- (b) works by date
- (c) manuscript by production data
- (d) works by manuscript

??:
- (a) manuscripts by (sometime) owner
- (b) purchase/sale events by manuscript and owner (composite key)
- (c) advertisements placed by manuscript and owner (composite key)
- (d) date by advertisement placed


NOTE: the approach I'm thinking of here is not to reduce the queries to a single SPARQL expression.  Rather to allow successive refinements/explorations that built up a set of results.  Some of these may involve manual inspection.

It might be that OWL-QL would provide a way to describe the compositions, in a way that can be mapped to SPARQL queries?  Could that reduction be done using JS in the browser?  Maybe worth talking to Ian Horrocks' team in CS?

....

Thought about worksets... maintain a local (or parallel) Solid Pod for storing workset lists of references.  Use URI of workset collection to pass workset con text forward when composing queries.  When a new selection is made, use Javascript in web page to create a new workset entry, and pass its URI forward?

....



# Teleconference discussion (2020-07-14)

_(Copied from Teams chat)_

The random ordering is disconcerting, but if you click on 'Links to here' from Ramon Llull's page an …, by David Lewis.
Profile picture of David Lewis.
David Lewis
16:51

The random ordering is disconcerting, but if you click on 'Links to here' from Ramon Llull's page and then page through them till you see a MS, almost every one you click through to has at least one P51.
So why are there only 3?, by David Lewis.

So why are there only 3?
I don't know - I'll come back and look at that.  I'm currently wrestling a semantic query for the pa …, by Graham Klyne.
16:53

I don't know - I'll come back and look at that.  I'm currently wrestling a semantic query for the page content.  Remember not all of them will be in the same collection.
Not sure I understand that last sentence (and it makes me wonder if I've misunderstood what this is …, by David Lewis.
Profile picture of David Lewis.
David Lewis
16:54

Not sure I understand that last sentence (and it makes me wonder if I've misunderstood what this is looking for)
OK, which URI are you looking at?, by Graham Klyne.
16:57

OK, which URI are you looking at?
Starting with Link http://vm-seldon.oerc.ox.ac.uk:10214/resource/?uri=http://ldf.fi/mmm/actor/bodley …, by David Lewis.
Profile picture of David Lewis.
David Lewis
16:57

Starting with http://vm-seldon.oerc.ox.ac.uk:10214/resource/?uri=http://ldf.fi/mmm/actor/bodley_person_120696927
Right, so I click on "who collects"... and get a list of 3 collections. , by Graham Klyne.
16:58

Right, so I click on "who collects"... and get a list of 3 collections. 
Whereas if you click links to here, you get a lot of MSS, by David Lewis.
Profile picture of David Lewis.
David Lewis
16:59

Whereas if you click links to here, you get a lot of MSS
Almost every MS has at least one collector, by David Lewis.

Almost every MS has at least one collector
I'm studying the query now... I'm thinking I may need a sub-query here... this is the query I'm usin …, by Graham Klyne.
17:00

I'm studying the query now... I'm thinking I may need a sub-query here... this is the query I'm using:
    <semantic-table         query=' PREFIX skos: <Link http://www.w3.org/2004/02/skos/core#&amp;gt; P …, by Graham Klyne.

    <semantic-table
        query='
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX efrbroo: <http://erlangen-crm.org/efrbroo/>
PREFIX mmm-actors: <http://ldf.fi/mmm/actor/>
PREFIX mmms: <http://ldf.fi/schema/mmm/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX crm: <http://www.cidoc-crm.org/cidoc-crm/>
PREFIX ecrm: <http://erlangen-crm.org/current/>
SELECT DISTINCT ?actor ?collector WHERE {
            VALUES ( ?actor )
              {
                ( <[[urlParam "actor" ]]> )
              }
            ?wce mmms:carried_out_by_as_author ?actor ;
                 efrbroo:R16_initiated ?w .
            ?mpe ecrm:P108_has_produced ?m .
            ?m a efrbroo:F4_Manifestation_Singleton ;
                 mmms:manuscript_work ?w ;
                 ecrm:P46i_forms_part_of ?col .
            ?col ecrm:P51_has_former_or_current_owner ?collector .
          } LIMIT 100'
 
Ah, I'd guess that only some are in explicit collections, so you also need a route via ?m P51 ?colle …, by David Lewis.
Profile picture of David Lewis.
David Lewis
17:02

Ah, I'd guess that only some are in explicit collections, so you also need a route via ?m P51 ?collector
(a) find all works by author (b) find all manuscripts containing each of those works (c) find all …, by Graham Klyne.
17:03

(a) find all works by author
(b) find all manuscripts containing each of those works
(c) find all collections that contain those manuscripts
(d) get owner(s) for each of those collections
Ah, that would explain it., by Graham Klyne.

Ah, that would explain it.
Yeah, I'm guessing (c) and (d) only apply to a minority of cases (those in named collections), by David Lewis.
Profile picture of David Lewis.
David Lewis
17:03

Yeah, I'm guessing (c) and (d) only apply to a minority of cases (those in named collections)
OK.  That's the sort of thing it helps to have someone more familiar with the data involved with., by Graham Klyne.
17:04

OK.  That's the sort of thing it helps to have someone more familiar with the data involved with.
It's a gotcha that came up in one or two project meetings. Ownership is complicated, by David Lewis.
Profile picture of David Lewis.
David Lewis
17:05

It's a gotcha that came up in one or two project meetings. Ownership is complicated
Though now I'm not sure why I didn't bypass the collection and go straight for the owner., by Graham Klyne.
17:05

Though now I'm not sure why I didn't bypass the collection and go straight for the owner.
Some ownership is recorded at the level of collection, by David Lewis.
Profile picture of David Lewis.
David Lewis
17:06

Some ownership is recorded at the level of collection
I think particularly you might see that for some Bod MSS, by David Lewis.

I think particularly you might see that for some Bod MSS
So I need to allow for both direct and indirect ownership?, by Graham Klyne.
17:07

So I need to allow for both direct and indirect ownership?
I think so, by David Lewis.
Profile picture of David Lewis.
David Lewis
17:07

I think so
OK., by Graham Klyne.
17:07

OK.
Sorry to have dropped a bomb, by David Lewis.
Profile picture of David Lewis.
David Lewis
17:07

Sorry to have dropped a bomb
That really just requires refining the queries.  The hard work has (and is) wrestling with the templ …, by Graham Klyne.
17:08

That really just requires refining the queries.  The hard work has (and is) wrestling with the templating system, and getting the required data to come through in the right form.
Leaving to walk the dog now, but do feel free to drop progress nuggets or questions here..., by David Lewis.
Profile picture of David Lewis.
David Lewis
17:08

Leaving to walk the dog now, but do feel free to drop progress nuggets or questions here...

[17:09] Graham Klyne
    Sure.  I've another meeting at 6.  Today hasn't been particularly productive - I got bogged down in RS/Metaphacts formatting issues - the diagnostics are not at all helpful (my errors, but I could use some help locating them).
​[17:32] Graham Klyne
    I've just noticed that there's a sort option on the result tables: click on the heading for alphabetical sort.
​[17:50] Graham Klyne
    I'm going to hazard a guess that the random ordering is due to internal caching that doesn't preserve result order.
​[17:50] Graham Klyne
    The query is updated for "who collects": see http://vm-seldon.oerc.ox.ac.uk:10214/resource/who_collects?actor=http://ldf.fi/mmm/actor/bodley_person_120696927&actorName=%22Llull,%20Ramon,%201232?-1316%22
​[17:57] Graham Klyne
    The query for "Manuscripts in collection" has also been updated.  I'm going to leave it there for now.


# Experiments with landing page (2020-07-17)

Have been trying to create a landing page based on OxLOD search page.

Search page queries aren't working.  Don't know why.  This  query was tested in the SPARQL query page and works fine.

```
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX efrbroo: <http://erlangen-crm.org/efrbroo/>
PREFIX mmm-actors: <http://ldf.fi/mmm/actor/>
PREFIX mmms: <http://ldf.fi/schema/mmm/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX crm: <http://www.cidoc-crm.org/cidoc-crm/>
PREFIX ecrm: <http://erlangen-crm.org/current/>
SELECT DISTINCT ?person ?label ?p ?o WHERE {
  # VALUES ?person { <http://ldf.fi/mmm/actor/bodley_person_120696927> }
  # VALUES ?p { rdf:type }
  ?person a ecrm:E21_Person ;
    skos:prefLabel ?label ;
    # ?p ?o .
} LIMIT 100
```


# Prepare for demo meeting and wrap up on 2020-07-28

See: https://github.com/gklyne/mmm-researchspace/blob/master/STATUS.md

Added: material for quick live-coding demo.

1. Sort out simple landing page, with options for:

    * ✅ list of people
    * ✅ list of works
    * ✅ why does filter not behave itself?

2. Replace "OXLOD" with "MMM" at

    * ✅ apps/researchspace/resources/com/metaphacts/ui/templates/header.hbs
    * ✅ apps/researchspace/resources/com/metaphacts/ui/templates/login.hbs
    * ✅ apps/researchspace/resources/com/metaphacts/ui/templates/html-head.hbs

3. Initial sketch of ideas for worksets and data exploration (and Solid)

4. Updates to status page

5. Screencast of intended demo (if time permits)


# Thoughts for using Solid-based working sets

See also: [Reflections on addressing research questions](./NOTES.md#reflections-on-addressing-research-questions-2020-07-09)

In our discussions about navigating MMM data (which could apply to many similar datasets), we discussed the idea of research questions that are addressed through a composition of data-refining queries.  A question that arises is:  how can we make such composition easy for non-technical researchers to use?

This work shows how ResearchSpace allows for application-specific queries to be embedded in web pages, and connected by web hyperlinks.  The demo queries are very specific to certain questions that one might ask of the data.  But an analysis of the proposed research questions suggests that there are a relatively small number of query elements that are combined in different ways when addressing different questions: many of these elements could be written once, and re-used, if there werre a way to compose the results.

One way to approach this would be to represent a research exploration as a connected graph of intermediate results, where graph connections are represented by hyperlinks.  The starting point for such a graph would be the entire set of data and a landing page.  As new queries are applied, the current "working set" of data would be updated, and the derivation of any intermediate stage could be represented as a provenance graph from the starting point.  

One thing required to implement this would be a way to capture and record the current working set at any point.  For this, I propose to use a Solid Pod [1][2].

[1] https://solidproject.org/

[2] https://solidproject.org/use-solid/

In the pod would be a container, identified by a URI, that might (for example) correspond to a research investigation.  Within this container would be worksets consisting primarily of a collection of entity data (e.g. for people, or works, or manuscripts, etc), a reference to another working set from which it was derived, and a query mechanism by which it was derived.  The query used would correspond to a hyperlink on a displayed web page that forms part of the research exploration.

This calls for a set of conventions for composing queries and working sets.  I imagine each query corresponds to a webpage that displays the result of that query.  The query would be part of the web page, and used to dynamically construct the display from a supplied working set and additional SPARQL endpoint(s) to which the query is directed.  The web page would be parameterized with the URI of a working set from which it is derived; e.g.

    http://query.example.org/works-in-manuscript/?ws=http://pod.example.org/workset/1234

Thus, a single working set URI would allow access to a complete history of how that working set was created.  And an exploration could be repeated against updated background data by repeating the derivation chain (NOTE: would need to recognize and substitute intermediate working set URIs when replaying a ddrivation).

    <<<add diagram>>>

Q: how to represent a working set.  
A: (At least) Two options:
   1. a set of URIs, so a set of resources - this was my initial thought
   2. an RDF graph - I'm leaning toward this, because it means a single SPARQL defines the composition.  But it does mean that the pages and the workset data might be more tightly coupled.  Maybe use Solid/LDP vocabulary for the simple case of representing (1), leaving the way clear for more subtle com,position options?

Q: derivation from multiple working sets?
A: possibly, but this would be harder to implement using a simple hyperlink

Q: SPARQL endpoint(s) used defined as fixed within each composing web page, as part of a global environment, or as parameters to the composing web pages?
A: ... start simple (fixed in page?) and see what requirements emerge?

Q: Would OWL-QL be a reasonable way to abstractly represent a working set derivation, which can be translated into SPARQL queries?  Maybe worth talking to Ian Horrocks' team in CS?
A: ...

Q: what about derivation steps using manual inspection.  That rather breaks the repeatability story.
A: ...

Q: What about adding new query elements?
A: This would probably still need technical expertise to create a new composable query element page, but the amount of work required should be limited, and the resulting page available for any subsequent investigations.


# Thoughts about patterns for ResearchSpace customization

(Expanding on an idea covered under "Reflections on addressing research questions".)

The ResearchSpace customizations to date have been rather _ad hoc_, with changes to existing ResearchSpace page templates and also creating new page templates.

Reflectng on these experiments, I propose a clearer pattern of separation of customizations from out-of-box ResearchSpace:

1.  For each main entity type (for [MMM](https://mappingmanuscriptmigrations.org/) these might be: Manuscripts, Works, Events, Actors, Places), create anew template for an "explore" page, which embeds exploration links that are appropriate to the entity type.  Each such page would be invoked with a workset of one or more entities of that type, and would present links that are associated with different queries against entities referenced in the workset.

    Within these "explore" pages would be filter boxes than can reduce the workset to a smaller subset for further exploration.

    The workset items would be listed in the explore page, along with links for each to invoke further queries, as well as a link to continue an exploration against the current workset after application of any filter.

2.  For each exploration query, create a new template for that query.  Like the "explore" page, these query pages would be invoked with a workset of one or more entities of some type.  The associated query would be executed against the supplied workset, and results presented as a table (which might be about different types of entity).  Each result entity would link back to the explore page for that entity type.  The page would similarly provide links for exploring all the results of a particular type.

    The intent is that the query pages follow a common pattern (and may share template code), and are always invoked by and link back to an "explore" page.  Adding a new query to those that are available for exploring a dataset would require (a) creating a nw query page, which would define a query and presentation of results, and (b) adding a new query link to the corresponding explore page.  This would require technical expertise in SPARQL, HTML, ResearchSpace, and the domain data model, but the resulting pages should be readily usable by all researchers and domain experts without such technical knowledge.

Notes:

1. I anticipate that singleton worksets would be supplied as a single URI query parameter, and multi-values worksets woukd be supplied as a URI refering to a workset description, possibly saved in a Solid data pod.

2. The hyperlinked chain of "explore" and "query" pages would be chained in a fashion similar to a functional programming modadic sequence, where the hyperlinking corresponds roughly to a monadic "bind" operation.

3. A chain of "explore" and "query" selections from some starting dataset amounts to a provenance description of some result.  Given such a description, it shouldbe possible to re-evaluate an exploration against an updated starting dataset.

4. The pattern as described assumes a chain of queries.  In practice, other kinds of selection may be required, such as manual selection from a workset.  Such queries should be possible to implement, but may affect the automatic replayability of provenance sequences.

5. This pattern does not yet account for queries that combine the results from multiple worksets.  This is an aspect that should be explored further in light of specific research questions that may require such capabilities.

6. Content negotiation and/or alternative links could (should?) be used to alow query results to be returned in formats other than another web page, for machine consumption.

