#! /bin/bash

####################################################################
# 1Password Cloud Backup                                           #
# restore                                                           #
#                                                                  #
# https://github.com/michael-batz/1password-backup                 #
####################################################################

print_usage()
{
    echo "1Password Cloud Restore"
    echo "usage: $0 -f <input file>"
    exit 0
}

# define variables
tool_op="op"
tool_jq="jq"

# parse arguments
while getopts "f:" option
do
    case "${option}" in
        f) var_inputfile=${OPTARG};;
        *) print_usage
    esac
done

# check arguments
if [ -z "${var_inputfile}" ]; then print_usage; fi

# decrypt and print to STDOUT
openssl enc -d -aes256 -in ${var_inputfile} | ${tool_jq}
