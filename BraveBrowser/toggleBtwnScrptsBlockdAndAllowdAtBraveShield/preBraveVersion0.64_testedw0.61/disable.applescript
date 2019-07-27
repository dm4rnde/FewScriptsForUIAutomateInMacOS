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


# This script will:
# 	change related UI element (from 'All scripts allowed') to 'Scripts blocked'


# Precondition to run:
#	- must have 'Brave Browser' opened AND 
# 	- must have tab opened showing web page AND 
# 	- must have 'script blocking' off ('Brave Shields ...' shows 'All scripts allowed') on that web page AND
# 	- there shouldn't be any other popups, search boxes (or similar) taking over the focus
# 	  within 'Brave Browser'


# Getting path to main script, for the purpose of calling subroutine from that script

tell application "Finder"
	set currPathStr to container of (path to me) as string
end tell

set currPathWScrptAsStr to currPathStr & "toggle.scpt"


# Having correct path, load the script
set mainScript to load script (alias (currPathWScrptAsStr))


# Call the subroutine
mainScript's toBlocked(true)
