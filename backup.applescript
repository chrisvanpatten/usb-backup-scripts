(* Uncompiled version of backup.scpt *)

on adding folder items to this_folder after receiving these_items
	repeat with current_item in these_items
		try
			display dialog "Would you like to begin the backup?" with title "Backup" buttons {"Yes", "No"}
			
			if result = {button returned:"Yes"} then
				do shell script POSIX path of current_item & "backup.sh"
				display dialog "The backup is complete." with title "Backup Complete" buttons {"OK"}
				
			else
				display dialog "The backup was aborted." with title "Backup Stopped" buttons {"OK"} with icon stop
				
			end if
			
		end try
	end repeat
end adding folder items to