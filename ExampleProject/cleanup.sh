#!/bin/bash
# this code will be executed when build finished
# or on interupt signal.

# skip cleanup argv
[[ "$SKIP_CLEANUP" == "true" ]] && return

echo -n "CLEANUP..."
$SUDO rm -fr "${BUILD_WORSPACE}/*"

echo " [DONE]"
