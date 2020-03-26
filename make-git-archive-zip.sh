# This scipt should be run in the researchspace git repository for which
# an archive (ZIP) file is required.
#
# NOTE: transferring via a GIT archive file avoids including a lot of 
# git housekeeping data that might intefere when the files are placed
# in another git repository.

BUNDLE_NAME="researchspace-bundle"

git archive -o ${BUNDLE_NAME}.zip \
            --prefix=${BUNDLE_NAME}/ \
            HEAD
