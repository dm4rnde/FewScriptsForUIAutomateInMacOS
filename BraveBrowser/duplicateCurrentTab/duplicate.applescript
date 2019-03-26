# Author: dm4rnde (dm4rnde@protonmail.com; https://github.com/dm4rnde)

# MIT License

# Copyright (c) 2019 dm4rnde (dm4rnde@protonmail.com)
# https://github.com/dm4rnde/FewScriptsForUIAutomateInMacOS

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


# Precondition to run:
# 	- must have 'Brave Browser' opened AND 
# 	- must have tab opened showing web page AND
# 	- there shouldn't be any other popups, search boxes, or similar taking 
#       over the focus within 'Brave Browser'

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
	# no continue; fail all
	return errorMessage2
	
end try
