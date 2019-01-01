#!/bin/bash

####################################################################
# 1Password Cloud Backup                                           #
# backup                                                           #
#                                                                  #
# https://github.com/michael-batz/1password-backup                 #
####################################################################

print_usage()
{
    echo "1Password Cloud Backup"
    echo "usage: $0 -f <output file>"
    exit 0
}

# define variables
tool_op="op"
tool_jq="jq"

# parse arguments
while getopts "f:" option
do
    case "${option}" in
        f) var_outputfile=${OPTARG};;
        *) print_usage
    esac
done

# check arguments
if [ -z "${var_outputfile}" ]; then print_usage; fi

# signin to 1Password
echo "1Password Cloud Backup"
echo "- signin to 1Password..."
eval $(${tool_op} signin)

# get a list of all items
echo "- get list of all items from 1Password..."
items=$(${tool_op} list items | ${tool_jq} --raw-output '.[].uuid')

# get all items from 1Password
output=""
for item in $items
do
    echo "  - get item ${item}..."
    output+=$(${tool_op} get item ${item})
done

# encrypt items and write to output file
echo "- store items in encrypted output file ${var_outputfile}..."
echo $output | openssl enc -e -aes256 > ${var_outputfile}

# signout from 1Password
echo "- signout from 1Password"
${tool_op} signout
