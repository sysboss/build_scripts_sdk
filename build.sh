#!/bin/bash
#############################################################
# Jenkins build script
#############################################################
# Description:
# Runs set of build steps related to the product version and
# modification/branch. Does cleanup on fail or interupt.
#############################################################
# Alexey Baikov <sysboss[@]mail.ru>
#############################################################

RUN_DIR="$( dirname "${BASH_SOURCE[0]}" )"
PRODUCT_NAME="ExampleProject"
MAJOR_RELEASE="7"
VERSION="7.2.1"
CUSTOM_MODIFICATION="some_fix"

# verify components exist
if [ ! -e "$RUN_DIR/lib/functions" ]; then
    echo "Build failed"
    echo "functions file is missing in $RUN_DIR/lib/functions"
    exit 2
fi

# load functions
. "$RUN_DIR/lib/functions"

function cleanup()
{
    require_file "cleanup.sh"
}

function on_exit()
{
    exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
        echo "JOB FINISHED SUCCESSFULY"
    else
        echo "JOB FAILED"
    fi
    exit $exit_code
}

# setup trap function
function sigHandler()
{
    if type on_exit | grep -i function > /dev/null; then
        trap 'on_exit $?' EXIT
    else
        echo "ERROR: on_exit function is not defined"
        exit 127
    fi

    # run clenup function
    trap cleanup HUP TERM INT
}

function main()
{
    require_file "build_step1.sh"
    require_file "build_step2.sh"
    # more steps here...
}

# FLOW START
sigHandler
main

