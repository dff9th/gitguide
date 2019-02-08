#!/usr/bin/bash

# move to the directory where this file exists
cd `dirname $0`

# copy source directory
SRC_DIR="./build/html"

# copy destination directory
DOC_NAME="gitguide"
APACHE_ROOT="/var/www/html"
DST_DIR="${APACHE_ROOT}/${DOC_NAME}"

# DST_DIR is already existed
if [ -d  ${DST_DIR} ]; then
    # remove the directory
    cmd="rm -rf ${DST_DIR}"
    ${cmd}
    # command failed 
    if [ $? -ne 0 ]; then
        echo "[ERROR] command is failed: ${cmd}" 1>&2
        exit -1
    fi
fi

# make the document root directory
cmd="mkdir ${DST_DIR}"
${cmd}
# command failed 
if [ $? -ne 0 ]; then
    echo "[ERROR] command is failed: ${cmd}" 1>&2
    exit -1
fi

# copy document
cmd="cp -rf ${SRC_DIR}/* ${DST_DIR}/"
${cmd}
# command failed 
if [ $? -ne 0 ]; then
    echo "[ERROR] command is failed: ${cmd}" 1>&2
    exit -1
fi

# set execute authorization that file is 644 and directory is 755
cmd="chmod -R a=rX,u+w ${DST_DIR}"
${cmd}
# command failed 
if [ $? -ne 0 ]; then
    echo "[ERROR] command is failed: ${cmd}" 1>&2
    exit -1
fi

# set user/group authorization
cmd="chown -R :apacheGroup ${DST_DIR}"
${cmd}
# command failed 
if [ $? -ne 0 ]; then
    echo "[ERROR] command is failed: ${cmd}" 1>&2
    exit -1
fi

