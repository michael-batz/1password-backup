# 1password-backup
Simple script for backup 1Password cloud data

These are just some simple scripts to create offline backups of 1Password cloud data. The backup script will use the 1Password CLI client to get all items from all vaults. These items (given in JSON format) will then be AES256 encrypted and stored to an output file.

At the moment, the restore script will decrypt the stored data and print the 1Password items in JSON format to STDOUT. 

## setup
The following tools are required for this script:

 * op (1Password CLI; https://support.1password.com/command-line-getting-started/)
 * jq (JSON processing; https://stedolan.github.io/jq/)

## usage

The following command will download all items from 1Password Cloud and store it into an AES256 encrypted output file. The script will ask for the passphrase to encrypt the output file.
```
./backup.sh -f <output file>
```

The following command will decrypt an existing output file and print the content of 1Password Cloud data in JSON format to STOUT:
```
./restore.sh -f <input file>
```
