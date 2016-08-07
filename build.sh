#!/bin/bash
#############################################################
# Build Script SDK
#############################################################
# Alexey Baikov <sysboss[@]mail.ru>
#
# Description:
# ------------
# This script is  a generic  skeleton for  build script  with
# useful functions and libraries.
#
# Designed  to  run set of  build steps  which are discovered
# recursively  inside  the project directory , according it's
# version and modification/branch.
#############################################################

###################################
# THIS VARIABLES SHOULD BE EXPORTED
###################################
# use: export VAR_NAME="value"
#
# Required variables
# ------------------
# PRODUCT_NAME
# MAJOR_RELEASE
# VERSION
# CUSTOM_MODIFICATION
#
# Example:
# --------
# PRODUCT_NAME="ExampleProject"
# MAJOR_RELEASE="7"
# VERSION="7.2.1"
# CUSTOM_MODIFICATION="some_fix"


# internal variables
RUN_DIR="$( dirname "${BASH_SOURCE[0]}" )"
LOCKFILE="$RUN_DIR/build.lock"
LOCK_FD=2
SUDO=""

INCLUDE=(
    "$RUN_DIR/lib/functions"
    "$RUN_DIR/lib/optparse/optparse.bash"
    "${RUN_DIR}/lib/get_artifact.sh"
)

# import all libraries
for ((i = 0; i < ${#INCLUDE[@]}; i++)); do
    if [ ! -e "${INCLUDE[$i]}" ]; then
        echo "ERROR: ${INCLUDE[$i]} library is missing"
    else
        source "${INCLUDE[$i]}"
    fi
done

# load getopts
opts=$(discover "getopts.sh")
source $opts
source $(optparse.build)

# use sudo if needed
[ "${USE_SUDO}" == "true" ] && SUDO=$(which sudo)

# use lock if needed
if [ "${USE_LOCK}" == "true" ]; then
    lock || die "Only one instance can run at a time"
fi

function cleanup() {
    require_file "cleanup.sh"
}

function initVariables() {
    require_file "init_vars.sh"
}

function on_exit()
{
    exit_code=$?

    [ "${USE_LOCK}" == "true" ] && lock_remove
    [[ $exit_code -eq 126 || $exit_code -eq 127 ]] && exit $exit_code

    cleanup
    echo ""
    echo "###############################"

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

function main() {
    require_file "_build_steps.sh"
}

# FLOW START
sigHandler
initVariables
main
