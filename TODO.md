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

3. [ ] Install RS 2.1 on VM environment.  Script as much as possible.

4. [ ] Load (unmodified) MMM data into RSA 2.1.

5. [ ] Configure semantic search over MMM data.

    - Once basic technical deployment is done, liaise with David L about domin specifics that are applicable to semantic search over MMM data.

6. [ ] Stretch goal:  try to repeat the above for RS 3.4.

    - Ask if there are instructions or commands for building the preview bundle from the source repo.


