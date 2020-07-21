# Outline plan for MMM ResearchSpace investigations

These notes are based initially on a discussion that took place on 2020-04-28, in light of the challenges we have working with ResearchSpace.  For more background, see [these notes](./NOTES.md).

## 2020-04-28 - notes from discussion

Lacking sufficient knowledge to create a preconfigured container instance of the ResearchSpace 3 preview bundle, I plan to revert to experiments using ResearchSpace 2.1 (the version that Thanasis deployed for OxLOD).  Earlier experiments have shown we can get it running using Thanasis' recipe, but that the system thus deployed isn't really suitable for containerization (due to the transient nature of containers: they reset each time they are run).

To get a persistent deployment, we propose to use a full virtual machine deployment, intended to be available for a short period so that MMM project members can evaluate its affordances.  Based on what we currently know, this approach seems to offer the least uncertainty in terms of what needs to be done.

Thus:

1. [x] Create new CentOS 7 (or 8?) VM on OeRC-based infrastructure, and request public access for ports needed to view ResearchSpace.

    - NOTE: should probably ensure that Kevin has access to Seldon/Trantor OpenStack environment, and a few recipes for running up VMs, for when my contract expires.  Will need a public/private key pair.

    - Note to self: Source copy of VMWare fusion for local experiments.  (Or use older MacBook?)

    - _2020-04-30: base VM is created, and have requested IP address and access through firewall._

2. [x] Ask Thanasis what he found out about configuring RS semantic search.  (Apparently requires some helper triples to be added?)

    - _2020-04-29: Sent email enquiry_
    - _2020-04-30: Response; no specific notes, but see online help (https://antheia-researchspace.oerc.ox.ac.uk/resource/Help:SemanticSearch)_
    - It looks as if RS 3.4 also has this capability; e.g. see http://localhost:10214/resource/Help:SemanticSearch.  But it's not clear if this enables the same capabilities as the interactive query builder on the public researchspace site.
    - Original query builder:  https://public.researchspace.org/resource/Start

3. [x] Install RS 2.1 on VM environment.  Script as much as possible.

4. [x] Load (unmodified) MMM data into RSA 2.1.

5. [ ] Explore research questions, constructing custom page templates as required.

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


## 20200717 - review anf final steps

For demo meeting and wrap up on 2020-07-28

See: https://github.com/gklyne/mmm-researchspace/blob/master/STATUS.md

Added: material for quick live-coding demo.

1. [x] Sort out simple landing page, with options for:

    * [x] list of people
    * [x] list of works
    * [x] why does filter not behave itself?
        - It appears that it works on the set of vlues returned from the query.  So need to ensure that skow:prefLabel values are returned, even if they are not explicitly displayed.

2. [x] Initial sketch of ideas for worksets and data exploration (and Solid)

3. [x] Updates to status page

4. Screencast of intended demo (if time permits)


