# Copyright (c) 2019 dm4rnde (dm4rnde@protonmail.com). The MIT License.


# Precondition to run:
# 	you must have 'Brave Browser' opened and 
# 	you must have tab opened showing web page and 
# 	(you must have 'script blocking' off ('Brave Shields ...' shows 'All scripts allowed') on that web page
# 	OR
# 	you must have 'script blocking' on ('Brave Shields ...' shows 'Scripts blocked') on that web page)
# 	(and there shouldn't be any other popups, search boxes, or similar taking over the focus
# 	within 'Brave Browser')


#test; uncomment 1 line at a time only
#toBlocked(true)
#toBlocked(false)

-- A subroutine, that will do all the work.
-- blockAllScripts : boolean : true  (to block all scripts -- to 'Scripts blocked')
-- blockAllScripts : boolean : false (to allow all scripts -- to 'All scripts allowed')
on toBlocked(blockAllScripts)
	
	tell application "Brave Browser" to activate
	
	# init vars
	tell application "Brave Browser" to set activeTabNme to get title of window 1
	set winNme to activeTabNme & " - Brave"
	set shldsBtnNme to "Brave Shields
Has access to this site"
	
	
	#####
	# 1. click on the lion icon on the 'address bar', which will open 'Brave Shields ...' overlay-like 
	#    element
	
	
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
	delay 1
	# It is very important to have some delay here,
	# to allow new UI element to appear
	
	
	#####
	# 2. then go to pre-last drop down and click on it to open drop-down;
	# 3. then go to intended new value, click on it, and wait until page reloads; 
	
	
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
	# Fine tune location so to click on pre-last drop down
	set xCooe to ((item 1 of overlyBrShieldPosn) + 150)
	set yCooe to ((item 2 of overlyBrShieldPosn) + 340)
	
	
	# It is difficult to get basic click working w/ applescript alone,
	# using non-applescript solution
	# https://discussions.apple.com/thread/3708948
	
	
	# Coordinates, from somewhere around where drop down is
	set x to xCooe
	set y to yCooe
	
	#(*finetunecoord)
	if blockAllScripts then
		set yShift to 25
	else
		set yShift to 3
	end if
	
	#(*finetunecoord)
	# After drop down has been opened, this is to adjust
	# coordinates to click certain text
	set y2 to (yCooe - yShift)
	
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
mouseClick(" & x & "," & y & ")				  # go to pre-last drop down and open drop-down
#(*finetunedelay)
time.sleep(1.5)							  # give it some time for UI to make changes appear
mouseClick(" & x & "," & y2 & ")				         # select intended new value
mouseMove(int(current_pos.x), int(current_pos.y))    # restore mouse position

END"
	
	#(*finetunedelay)
	# Must give it some time for reloading
	# (as don't want to press Escape too soon,
	# as Escape has another meaning in browser --
	# stop loading the page --, which we don't 
	# want; we just want to hide the UI element 
	# 'Brave Shields ...')
	delay 3.5
	
	
	#####
	# 4. finally close the 'Brave Shields ...' element
	
	
	tell application "System Events"
		# Keyboard key Escape
		key code 53
		
		# Second Escape press is to cover those cases, 
		# when intended value was already selected
		# and no drop down value was actually changed
		# (nothing changed)
		#(*finetunedelay)
		delay 0.5
		key code 53
	end tell
	
end toBlocked
