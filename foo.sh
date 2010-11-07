#!/bin/bash -
#
# Copyright (c) 2010 by Stephen Wai
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# # LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Description:
# Basic boilerplate bash script
# which accomplishes some simple tasks:
# accepts arguments, reads a file, runs unix command
#

DATESTAMP=`date "+%Y%m%d.%H%M"`
ROOT_DIR=`dirname $0`

# print usage
usage() {
    echo ""
    echo "Usage: `basename $0` [-a] [-f file] [-z foo]"
    echo ""
}

# random stuff
do_something() {
    echo "****** doing something"
    OUT=`uname -rs | sed s/Darwin/thingie/ 2> /dev/null`
    echo " uname out: $OUT"

    # call script via SSH
    #ssh ${HOST_USER}@${HOST_SERVER} "~/scripts/deploy.sh -t ${arg1} -f ${arg2}"
}

# read a file
read_file() {
    FILE=${1}
    if [ ! -f ${FILE} ]; then
        echo "file not found: ${1}"
        exit 1
    fi

    # for loop interprets whitespace-separated
    echo "****** for-loop:"
    for i in `cat ${FILE}`; do
        echo $i
    done
    echo ""

    # while loop interprets line
    echo "****** while loop:"
    while read line
    do
        echo $line
    done < ${FILE}
    echo ""
}

# main
PASSED_ARG=false

# parse options
while getopts "af:z:" opt; do
  case $opt in
    a)
        PASSED_ARG=true
        do_something
    ;;
    f)
        PASSED_ARG=true
        read_file $OPTARG
    ;;
    z)
        PASSED_ARG=true
        if [ "$OPTARG" = "foo" ]; then
            echo "****** foo is cool"
            echo ""
        elif [ "$OPTARG" = "bar" ]; then
            echo "****** bar is cool too"
            echo ""
        else
            echo "****** nope"
            echo ""
        fi
    ;;
    :)
      echo "  Option -$OPTARG requires an argument."
      usage
      exit 1    
    ;;
  esac
done

if [ $PASSED_ARG = false ]; then
    usage
    exit 1
fi

exit 0
