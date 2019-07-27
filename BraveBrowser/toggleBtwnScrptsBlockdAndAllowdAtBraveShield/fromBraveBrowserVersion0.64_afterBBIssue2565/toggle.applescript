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
# 	- (must have 'script blocking' off ('Brave Shields ...' shows 'Scripts blocked' toggle off) on that web page
# 	  OR
# 	  must have 'script blocking' on ('Brave Shields ...' shows 'Scripts blocked' toggle on) on that web page) AND
# 	- there shouldn't be any other popups, search boxes, or similar taking over the focus
# 	  within 'Brave Browser'


#for test
#toggleScriptsBlocked()

on toggleScriptsBlocked()
	
	tell application "Brave Browser" to activate
	
	# init vars
	tell application "Brave Browser" to set activeTabNme to get title of window 1
	set winNme to activeTabNme & " - Brave"
	set shldsBtnNme to "Brave Shields
Has access to this site"
	
	
	#
	#   1. click on the lion icon on the 'address bar', which will open 'Brave Shields ...' overlay-like 
	#       element
	#
	# # # # #
	
	
	#(*finetunedelay)
	#delay 1
	
	try
		tell application "Brave Browser" to activate
		
		tell application "System Events" to tell process "Brave"
			
			try
				set theBtn to button shldsBtnNme of group 1 of group 1 of window winNme
			on error errorMessage1 number errorNumber1
				#guard against: Private Window is opened
				#Private Window has ' (Private)' eppended to a window name 
				set winNme to winNme & " (Private)"
			end try
			set theBtn to button shldsBtnNme of group 1 of group 1 of window winNme
			#now if it is not even Private Window case, then just fail
			
			tell theBtn to perform action "AXPress"
			
		end tell
		
	on error errorMessage2 number errorNumber2
		display dialog "ERROR2: " & errorMessage2
		# in that case, fail all
		return errorMessage2
	end try
	
	
	#(*finetunedelay)
	delay 0.4
	# It is very important to have some delay here,
	# to allow new UI element to appear
	
	
	#
	#   2. then go to certain toggle and click on it; 
	#
	# # # # #
	
	
	#tell application "Brave Browser" to activate
	
	try
		# Will get coordinates of window 1 (which is a 'Brave Shields ...', an overlay-like element)
		tell application "System Events" to tell process "Brave"
			set overlyBrShieldPosn to get position of image 1 of group 1 of window 1
		end tell
	on error errorMessage3 number errorNumber3
		display dialog "ERROR3: " & errorMessage3
		# in that case, fail all
		return errorMessage3
	end try
	
	#(*finetunecoord)
	# Fine tune location so to click specific toggle
	set xCooe to ((item 1 of overlyBrShieldPosn) + 315)
	set yCooe to ((item 2 of overlyBrShieldPosn) + 305)
	
	
	# Because it is difficult to get basic click working w/ 
	# applescript alone, using non-applescript solution
	# https://discussions.apple.com/thread/3708948
	
	
	# Coordinates, from somewhere around where toggle is
	set x to xCooe
	set y to yCooe
	
	do shell script " 

/usr/bin/python <<END

import time
from Quartz.CoreGraphics import CGEventCreate 
from Quartz.CoreGraphics import CGEventGetLocation
from Quartz.CoreGraphics import CGEventCreateMouseEvent
from Quartz.CoreGraphics import CGEventPost
from Quartz.CoreGraphics import kCGMouseButtonLeft
from Quartz.CoreGraphics import kCGHIDEventTap
from Quartz.CoreGraphics import kCGEventMouseMoved
from Quartz.CoreGraphics import kCGEventLeftMouseDown
from Quartz.CoreGraphics import kCGEventLeftMouseUp

def mouseEvent(type, pos_x, pos_y):
          e = CGEventCreateMouseEvent(None, type, (pos_x, pos_y), kCGMouseButtonLeft)
          CGEventPost(kCGHIDEventTap, e)

def mouseMove(pos_x, pos_y):
          mouseEvent(kCGEventMouseMoved, pos_x, pos_y)

def mouseClick(pos_x, pos_y):
          mouseEvent(kCGEventLeftMouseDown, pos_x, pos_y)
          mouseEvent(kCGEventLeftMouseUp, pos_x, pos_y)

cg_event = CGEventCreate(None)
current_pos = CGEventGetLocation(cg_event)    # save current mouse position
mouseClick(" & x & "," & y & ")                          # go to certain (specified by coords) toggle and click on it
#(*finetunedelay)
time.sleep(0.5)							  # give it some time for UI to make changes appear
mouseMove(int(current_pos.x), int(current_pos.y))    # restore mouse position

END"
	
	#(*finetunedelay)
	# Must give it some time for reloading
	# (as don't want to press Escape too soon,
	# as Escape has another meaning in browser --
	# stop loading the page --, which we don't 
	# want; we just want to hide the UI element 
	# 'Brave Shields ...')
	delay 1.5
	
	
	#
	#   4. finally close the 'Brave Shields ...' element 
	#   
	# # # # #
	
	
	tell application "System Events"
		# Keyboard key Escape
		key code 53
		
		# TODO this needs verifying if it is needed anymore
		# Second Escape press is to cover those cases, 
		# when nothing changed TODO (check if needed at all)
		#(*finetunedelay)
		#delay 0.5
		#key code 53
	end tell
	
end toggleScriptsBlocked
