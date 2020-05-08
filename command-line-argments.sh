#!/bin/bash

# This script is a basic guide to accept named options/arguments from the command line and provide validation and defaulting logic.
# Uncomment  set -x to see how the script works as it runs.

# set -x

##############################
# Functions
##############################

function usage() {
  echo "This is a sample script that shows how to use named arguments in a shell script."
  echo "Usage: command-line-arguments.sh -m <value> -h <value>  [-i <value>]"
  echo "  -m | --module : Required. An contrived file path argument for this example."
  echo "  -h | --host : Required. Another contrived argument for this example."
  echo "  -i | --interval : Optional.  Default 10. The contrived option for this example."
  echo "  ?  | --help | -help : Display this usage message."
}

#######################
# Constants
#######################

# Loop through arguments, two at a time for key and value
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        --module|-m)
            readonly MODULE="$2" # declare as constant
            shift # past the argument
            ;;
        --host|-h)
            readonly HOST="$2" # declare as constant
            shift # past the argument
            ;;
        --interval|-i)
            readonly INTERVAL="$2" #declare as constant
            shift # past argument
            ;;
        ?|-help|--help)
            usage
            exit 2
            ;;
        *)
            echo "Unknown parameter ${key}"
            usage
            exit 2
            ;;
    esac
    shift # past argument or value
done

arguments_valid="true"
if [[ -z "${MODULE}" ]]; then   #abort if there was module path provided
  echo "--module is required"
  arguments_valid="false"
fi
if [ ! -f "${MODULE}" ]; then   #abort if there was no file for the provided argument
  echo "module [$MODULE] not found"
  arguments_valid="false"
fi
if [[ -z "${HOST}" ]]; then     #abort if there was no host provided
  echo "--host is required"
  arguments_valid="false"
fi

if [[ "${arguments_valid}" == "false" ]]; then
  usage
  exit 2
fi

if [ -z "${INTERVAL}" ]; then    #set default if not provided
  INTERVAL=10
fi


echo "MODULE: ${MODULE}"
echo "HOST: ${HOST}"
echo "INTERVAL: ${INTERVAL}"
