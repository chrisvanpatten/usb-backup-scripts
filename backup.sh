#!/bin/bash

# Define which folders to back up
SOURCE=(
"/Users/Chris/Websites/Projects"
"/Users/Chris/Websites/Personal"
"/Users/Chris/Websites/Clients"
)

# Define where we want to put our archive files. Using pwd
# will put the files in the same directory as this backup
# script, but you can use a full absolute path too.
DESTINATION=`pwd`

###
# You probably don't need to edit below here.
###

# Define the tempdir where we'll create the TAR file
TEMPDIR=`mktemp -d /tmp/cvp-backup.XXXXXXXXXX`

# Loop through your source folders
for i in "${SOURCE[@]}"
do
	# Set the filename where we'll put the backup TAR file
	BACKUPFILE=$TEMPDIR/${i//\/}.tar

	# Create the TAR archive
	tar -cpf $BACKUPFILE -C $i .

	# Sync the TAR file to the USB disk, removing the TAR
	# file from your main disk when finished
	rsync --remove-source-files $BACKUPFILE $DESTINATION
done

# When all source folders have been archived and copied to
# the destination disk, remove the tempdir
rm -r $TEMPDIR

# Exit successfully
exit 0
