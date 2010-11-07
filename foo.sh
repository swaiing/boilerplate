#!/bin/bash -
#
# basic boilerplate bash script
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
