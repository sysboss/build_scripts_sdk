#!/bin/bash
#####################################
# Sub functions to get artifacts
#####################################

function wget_url()
{

    local URL=$1
    local OUTPUT=${2:-}
    set -e

    if [ "x$OUTPUT" == "x" ];then
        echo -n "  -> Downloading from URL: ${URL} ..."
        $SUDO wget ${URL} &> /dev/null
    else
        echo -n "  -> Downloading from URL: ${URL} ..."

        if [ -d "${OUTPUT}" ];then
            local _OUTPUT_filename=$(basename "${OUTPUT}")
            local _OUTPUT="${OUTPUT}/${_OUTPUT_filename}"
            $SUDO wget ${URL} -O ${_OUTPUT} &> /dev/null
        else
            $SUDO wget ${URL} -O ${OUTPUT} &> /dev/null
        fi
    fi
}

function curl_url()
{
    local URL=$1
    local OUTPUT=${2:-}

    set -e

    if [ "x$OUTPUT" == "x" ];then
        echo -n "  -> Downloading from URL: ${URL} ..."
        $SUDO curl -L -O ${URL} &> /dev/null
    else
        echo -n "  -> Downloading from URL: ${URL} ..."
        $SUDO curl -L ${URL} -o ${OUTPUT} &> /dev/null
    fi
}

function get_url()
{
    local URL=$1
    local OUTPUT=${2:-}
    local get_manager=""

    set +e

    get_manager=`which wget 2> /dev/null`

    if [ "x${get_manager}" != "x" ];then
        wget_url $@
    else
        get_manager=`which curl 2> /dev/null`
        if [ "x${get_manager}" != "x" ];then
            curl_url $@
        else
            echo "ERROR: wget or curl command missing"
            exit 127
        fi
    fi
    echo " [DONE]"
}

function get_file_from()
{
    local src=$1
    local dest=$2
    local name=$3 || 'file'

    echo " - Getting $name"

    if [[ "${src}" =~ http:// || "${src}" =~ https:// ]]; then
        get_url "${src}" "${dest}"
    else
        cp "${src}" "${dest}"
    fi
}

