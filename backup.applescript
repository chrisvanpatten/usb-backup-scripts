(* Uncompiled version of backup.scpt *)

(* Separate method to check for the existence of a file; required because OS X weirdness *)
on FileExists(theFile) -- (String) as Boolean
	tell application "System Events"
		if exists file theFile then
			return true
		else
			return false
		end if
	end tell
end FileExists

(* Whenever an item is added to the watched folder [/Volumes/]... *)
on adding folder items to this_folder after receiving these_items
	repeat with current_item in these_items
		
		(* Check to see if the backup.sh file exists *)
		if FileExists(POSIX path of current_item & "backup.sh") then
			
			try
				(* Ask if we should backup *)
				display dialog "Would you like to begin the backup?" with title "Backup" buttons {"Yes", "No"}
				
				if result = {button returned:"Yes"} then
					(* Run the script, and trigger a message when complete *)
					do shell script POSIX path of current_item & "backup.sh"
					display dialog "The backup is complete." with title "Backup Complete" buttons {"OK"}
					
				else
					(* Abort the backup *)
					display dialog "The backup was aborted." with title "Backup Stopped" buttons {"OK"} with icon stop
					
				end if
			end try
			
		end if
		
	end repeat
end adding folder items to
