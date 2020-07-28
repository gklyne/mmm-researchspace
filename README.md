# Create and run Docker containers for Blazegraph and ResearchSpace

This project contains files, scripts and other resources for creating Docker containers for Blazegraph and ResearchSpace.

See also:

- [Briefing notes for ResearchSpace investigations](./BRIEFING.md).
- [Notes of attempts to configure ResearchSpace](./NOTES.md).
- [Summary of activities in MMM/ResearchSpace investigations](./SUMMARY.md).
- [Current status of MMM data in ResearchSpace](./STATUS.md).


# Contents

There are several subdirectories here, mainly corresponding to different attempts to deploy ResearchSpace:

- `researchspace`: initial attempt to build system using instructions for OxLOD deployment.  Fails because of missing intermediate repository used.
- `blazegraph`: setting uop BlazeGraph in a Docker container.  Not used in final demo.
- `researchspace-2.1`: failed attempt to use RS 2.1 configuration data witn RS 3.4 software.
- `researchspace-3.2`: creates an instance of RS 3.2 based on a British Museum preview release 3.4, and configuration data from GitHub for RS 3.2.  This was a dead-end experiment.
- `researchspace-3.4`: creates an instance of RS 3.2 based on a British Museum preview release, with MMM data loaded.  The deployment itself works, but attampts to customize it to use alternati8ve ontologies were not successful.  With unmodified MMM data, the ResearchSpace entity displays do not recognize MMM entity details which use diufferent namespace URIs.  It was also tried with modified (hand-edited) MMM data, in which the namespace URIs were updated, and MMM entities could be displayed by RS.
- `researchspace-demo`: an earlier experiment to create a dockerized version based on the British Museum preview release 3.4 and demo data.  This worked OK and was easy to deploy (but subsequent attempts to customize proved problematic).
- `researchspace-preview`: similar to `researchspace-demo`, but without the British Museum demo data loaded.
- `researchspace-vm`: creating a clone of the OxLOD deployment using a persistent virtual machine and extensive manual configuration.  This is the basis for the example modified RS displays used with unmodified MMM data.  The notes in this directory do not cover the later stages of manually retrieving and deploying OxLOD RS software and configuration data using the basic Java/Python environment set up on this VM.  It contains a script used for loading MMM data into BlazeGraph.

    Ignore the notes for building ResearchSpace - in the end, we just copied software and files from antheia.ox.ac.uk - the process udsed insn't documented as such, but cpies of the command history files have been added to this directory - see `history-researchspace.txt`.

The mmm-researchspace project root directory contains:

- various notes
- copies of the modified configuration files and page templates used for the customized MMM data displays deployed in the `researchspace-vm` setup.

# Summary

See: [Summary of activities in MMM/ResearchSPace investigations](/SUMMARY.md).

