# Copyright (c) 2019 dm4rnde (dm4rnde@protonmail.com). The MIT License.

# Precondition to run:
# 	- must have 'Brave Browser' opened and 
# 	- must have tab opened showing web page
# 	- (and there shouldn't be any other popups, search boxes, or similar taking over the focus
# 	within 'Brave Browser')

tell application "Brave Browser" to set activeTabNme to get title of window 1
set winNme to activeTabNme & " - Brave"

try
	tell application "Brave Browser" to activate
	tell application "System Events"
		tell process "Brave"
			
			try
				tell UI element activeTabNme of tab group 1 of group 1 of window winNme to perform action "AXShowMenu"
			on error errorMessage1 number errorNumber1
				#Private Window has additional ' (Private)' appended to a name 
				set winNme to winNme & " (Private)"
				tell UI element activeTabNme of tab group 1 of group 1 of window winNme to perform action "AXShowMenu"
			end try
			
			delay 0.5
			keystroke "d"
			delay 0.5
			keystroke return
			
		end tell
	end tell
on error errorMessage2 number errorNumber2
	display dialog "ERROR2: " & errorMessage2
	# no continue, fail all
	return errorMessage2
end try