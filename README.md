# Using ResearchSpace with MMM data

The MMM-ResearchSpace activity was a short exploration of the potential for using [ResearchSpace](https://www.researchspace.org/) to provide alternative ways of accessing the data collected by the [Mapping Manuscript Migrations](https://mappingmanuscriptmigrations.org/en/) project.

This repository contains files, scripts, notes and other resources for deploying Blazegraph and ResearchSpace.

Note that there have been many updates to [ResearchSpace in GitHub](https://github.com/researchspace/researchspace) since our earlier investigations, and it is possible that many of the problems with installing ResearchSpace noted have been resolved.  I would recommend revisiting the [installation instructions](https://github.com/researchspace/researchspace#developing-and-building-from-sources) as part of any future effort to build on this exploration.

NOTE that the deployed ResearchSpace system is experimental, and not suitable for production use.


# Summary

I have attempted to summarize our ResearchSpace investigations in [Summary of activities in MMM/ResearchSpace investigations](./SUMMARY.md).

See also:

- [Reflections on addressing MMM research questions](https://docs.google.com/document/d/1ABrdNtaQ80xdPd1neZBuqWdCGWMbVG7ayHuTgaQZlnk/edit?usp=sharing) (Google doc).  This high-level document summarizes an approach to exploring MMM research questions using ResearchSpace, and reflects the end point of our exploratory work.
- [Thoughts for using Solid-based working sets](https://docs.google.com/document/d/1S8ZUbXVB1HM0Btei8NX2RelDa-utu129IVSuOdOmlgk/edit?usp=sharing) (Google doc).  This is a semi-technical document about some ideas that were raised by our exploratory work.  The ideas were only partially tested, and these notes are intended as possible input to future work in this area.
- [Briefing notes for ResearchSpace investigations](./BRIEFING.md).  These are notes from an initial meeting that set the initial direction of our explorations.  The challenges of working with ResearchSpace mean that these initial goals were not fully realized, but the they give a sense of what we were trying to achieve.
- [Current status of MMM data in ResearchSpace](./STATUS.md).  This is a high-level technical description of the ResearchSpace demonstration setup with MMM data loaded and customizations applied.
- [ResearchSpace deployment options review](./Deployment-options-review.md).  These are a high-level technical notes about the various options for deploying ResearchSpace that were attempted.
- [Notes of attempts to configure ResearchSpace](./NOTES.md).  These are technical working notes from attempts to customize ResearchSpace for use with MMM.  It in  the style of an ongoing lab notebook rather than a specific set of outcomes or conclusions.
- [Thoughts about patterns for ResearchSpace customization](https://github.com/gklyne/mmm-researchspace/blob/master/NOTES.md#thoughts-about-patterns-for-researchspace-customization).  These are some technical notes about how one might spproach constructing customizations to ResearchSpace.  They were written after the initial experiments had been constructed, and reflect experience from doing that, and do not closely reflect the actual implementation of the MMM demonstratiomn of ResearchSpace.


# Repository contents

There are several subdirectories here, mainly corresponding to different attempts to deploy ResearchSpace:

- `researchspace`: initial attempt to build system using instructions for OxLOD deployment.  Fails because of missing intermediate repository used.
- `blazegraph`: setting uop BlazeGraph in a Docker container.  Not used in final demo.
- `researchspace-2.1`: failed attempt to use RS 2.1 configuration data witn RS 3.4 software.
- `researchspace-3.2`: creates an instance of RS 3.2 based on a British Museum preview release 3.4, and configuration data from GitHub for RS 3.2.  This was a dead-end experiment.
- `researchspace-3.4`: creates an instance of RS 3.2 based on a British Museum preview release, with MMM data loaded.  The deployment itself works, but attampts to customize it to use alternati8ve ontologies were not successful.  With unmodified MMM data, the ResearchSpace entity displays do not recognize MMM entity details which use diufferent namespace URIs.  It was also tried with modified (hand-edited) MMM data, in which the namespace URIs were updated, and MMM entities could be displayed by RS.
- `researchspace-demo`: an earlier experiment to create a dockerized version based on the British Museum preview release 3.4 and demo data.  This worked OK and was easy to deploy (but subsequent attempts to customize proved problematic).
- `researchspace-preview`: similar to `researchspace-demo`, but without the British Museum demo data loaded.
- `researchspace-vm`: creating a clone of the OxLOD deployment using a persistent virtual machine and extensive manual configuration.  This is the basis for the example modified RS displays used with unmodified MMM data.  The notes in this directory do not cover the later stages of manually retrieving and deploying OxLOD RS software and configuration data using the basic Java/Python environment set up on this VM.  It contains a script used for loading MMM data into BlazeGraph.

    Ignore the notes for building ResearchSpace - in the end, I just copied software and files from antheia.ox.ac.uk - copies of the command history files have been added to this directory - see `history-researchspace.txt`.

The mmm-researchspace project root directory contains:

- various notes
- copies of the modified configuration files and page templates used for the customized MMM data displays deployed in the `researchspace-vm` setup.

