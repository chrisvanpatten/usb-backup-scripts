#!/bin/bash

# Define which folders to back up
SOURCE=(
"/Users/Chris/Websites/Projects"
"/Users/Chris/Websites/Personal"
"/Users/Chris/Websites/Clients"
)

# Define where you want to put your archive files
DESTINATION="/Volumes/cvp-backup"

###
# You probably don't need to edit below here
###

# Define the tempdir where we'll create the TAR file
TEMPDIR=`mktemp -d /tmp/usb-backup.XXXXXXXXXX`

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
