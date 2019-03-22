# Copyright (c) 2019 dm4rnde (dm4rnde@protonmail.com). The MIT License.


# "Set To Scripts Allowed"

# This script will:
# 	change related UI element (from 'Scripts blocked') to 'All scripts allowed'


# Precondition to run:
#	you must have 'Brave Browser' opened AND 
#	you must have tab opened showing web page AND 
#	you must have 'script blocking' on ('Brave Shields ...' shows 'Scripts blocked') on that web page AND
#	and there shouldn't be any other popups, search boxes (or similar) taking over the focus
#	within 'Brave Browser'


# Getting path to main script, for the purpose of calling subroutine from that script

tell application "Finder"
	set currPathStr to container of (path to me) as string
end tell

set currPathWScrptAsStr to currPathStr & "toggle.scpt"


# Having correct path, load the script
set mainScript to load script (alias (currPathWScrptAsStr))


# Call the subroutine
mainScript's toBlocked(false)
