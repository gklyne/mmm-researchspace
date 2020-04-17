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

Created new subdirectory for ResearchSpace 2.1, which appears to be the instnance that Thanassis installed.  Uses 3.4 software with 2.1 data.  Initially get missing resource error:  it appears that a key namespace URI has changed.

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

Now need to make it show up in ResearchSpace.



