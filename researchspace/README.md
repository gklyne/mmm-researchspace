This directory contains files for building a Docker image with researchspace from source pulled from GitHub.

STATUS [2020-02-25]:

1. the build seems to work as far as it goes
2. the final stage, which involves SBT (see start-researchspace.sh), has not been captured in the docker file, so needs to be repeated each time the container is restarted - this can take 5 minutes or so
3. the resulting image presents a blank page after login using admin/admin

