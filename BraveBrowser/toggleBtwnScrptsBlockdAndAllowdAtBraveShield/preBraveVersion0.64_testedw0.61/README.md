## Switch between 'Scripts blocked' and 'All scripts allowed' (under Brave Shield, under Brave Browser)


| CATEGORY 		| PROGRAM | STATUS 	 |
| :------------ | :--------------| :---------|
| UI automation | Brave Browser  | **WORKS** |


&nbsp;

```
Note! The word 'script' has 2 different meanings in current text: first, script as AppleScript — 
something stored as .applescript or .scpt; and then, script as JavaScript — something that is 
being blocked/allowed by browser.
```

&nbsp;

### Problem

##### DESCRIPTION

*Brave Browser* does not have option to **toggle between values 'All scripts allowed' and 'Scripts blocked'**  **with keyboard shortcut**. 

*'All scripts allowed' and 'Scripts blocked' refers to the part under 'Brave Shields' where user can block JavaScript scripts from running — or instead, allow them to run — on domain of currently opened page/url.*

*(Other, but not that relevant, sidenote:
https://github.com/brave/brave-browser/issues/3717)*

&nbsp;

##### PROCEDURE

At the moment, to change value from existing to intended: 

| you> | <program |
| :------------ | :--------------| 
| 1. move mouse pointer to click on the lion icon located on the right (on the 'address bar'), which | brings up the 'Brave Shields' box |
| 2. then move mouse to go to second from bottom drop-down element and click on it, this | opens drop-down | 
| 3. then move mouse to go to intended new value (in that opened drop-down), click on it, and wait until browser | reloads page |
| 4. finally press escape key on keyboard (or move mouse away to some neutral area and click), which | closes the 'Brave Shields' |

&nbsp;

### Solution

##### DESCRIPTION

Script [`toggle.applescript`] will do UI automation (will go through mentioned steps 1. to 4.), and based on input will either:

- change (from 'Scripts blocked') to '**All scripts allowed**'
[`enable.applescript`]

- or change (from 'All scripts allowed') to '**Scripts blocked**'
[`disable.applescript`]

&nbsp;

##### PROCEDURE

```
Note! Instead of doing toggle with one shortcut, using 2 shortcuts here. One will allow and the 
other will block.
```

To allow:

| you> | UI automation script> | <program | 
| :------------ | :--------------| :--------------|  
| 1. press shortcut, which will trigger | 1. ... **click on the lion icon** ... | brings up the 'Brave Shields' box |
|| 2. ... **move mouse to ... second from bottom drop-down element and click on it** ... | opens drop-down | 
|| 3. ... **move mouse to ... [All scripts allowed] (in that opened drop-down), click on it** ... | reloads page |
|| 4. **finally press escape key** ... | closes the 'Brave Shields' |

To block:

| you> | UI automation script> | <program | 
| :------------ | :--------------| :--------------|  
| 1. press shortcut, which will trigger | 1. ... **click on the lion icon** ... | brings up the 'Brave Shields' box |
|| 2. ... **move mouse to ... second from bottom drop-down element and click on it** ... | opens drop-down | 
|| 3. ... **move mouse to ... [Scripts blocked] (in that opened drop-down), click on it** ... | reloads page |
|| 4. **finally press escape key** ... | closes the 'Brave Shields' |


&nbsp;

### Specifics (environment)

- **AppleScript** 2.7
- **Python** 2
- **Brave Browser** 0.61.51 Chromium: 73.0.3683.75 (Official Build) (64-bit)
- **macOS** 10.13.6

&nbsp;

### Limitations

- run time (~6s)
- before using, fine-tune of certain marked places 
(*finetunecoord and 
*finetunedelay) might be needed (because of different UI setups / future changes in browser's UI); might take some tries to get all working
- can't interrupt and use any UI, while AppleScript is running

&nbsp;

### Disclaimer

This is just:
 
- AS IS; no guarantees that it will work for you
- does not claim to be effective nor best solution
- a custom and temporary remedy

&nbsp;

---

&nbsp;

### Guide to installation 
##### ATTACH SHORTCUT TO THE APPLESCRIPT SCRIPT

```
Bellow is just one possible approach on how keyboard shortcut could be attached to AppleScript 
script. Additionally, especially when new at it, it might not go as smoothly as that.
```

1. **Convert toggle.applescript to toggle.scpt**
    * Open `toggle.applescript` file in '`Script Editor.app`' (double-click might already open it)
    * `File>Export...`
    * under '`File Format`' select `Script`
    * save as `toggle.scpt` to your preferred location 'location A' (any location of your choosing)
    * you can now close `toggle.applescript`
      &nbsp; 
        
2. **Convert disable.applescript to an app**
    * Open `disable.applescript` file in '`Script Editor.app`' 
    * `File>Export...`
    * under '`File Format`' select `Application`
    * save as `setToScrptsBlockdCurrPgBraveShieldBraveBrowser.app` (this file name is just an example, you can name as you prefer) to 'location A'
    * you can now close `disable.applescript`
      &nbsp;
      
3. **Give your app Accessibility permission**; without this, app will not run
    * Go to `'System Preferences'>'Security and Privacy'>Privacy>Accessibility`
    * add `setToScrptsBlockdCurrPgBraveShieldBraveBrowser.app` (from 'location A') to that allowed list there
      &nbsp;
      
4. **Create a service that will launch your app**
    * Open `Automator.app`
    * `File>New...`
    * select `Service`
    * change first drop down to '`no input`'
    * and second drop down to '`Brave Browser.app`' ('`any application`' could also work)
    * leave the other settings as they are
    * search for '`Launch Application`'
    * double-click on '`Launch Application`', box-like area opens
    * from that box-like area open drop-down and choose '`Other...`', then browse to select `setToScrptsBlockdCurrPgBraveShieldBraveBrowser.app` (from 'location A')
    * save — here, will save this new service as `serviceToSetToScrptsBlockdCurrPgBraveShieldBraveBrowser`
    * you can now close `Automator.app`
      &nbsp;
      
5. **Attach a shortcut to your service**
    * Go to `'System Preferences'>Keyboard>Shortcuts>Services>General`
    * `serviceToSetToScrptsBlockdCurrPgBraveShieldBraveBrowser` should be listed there
    * there, for `serviceToSetToScrptsBlockdCurrPgBraveShieldBraveBrowser`
      * just on the left of the service name check `✓` the checkbox
      * on the right of the service click on `none` (or `Add Shortcut`) to **set shortcut** (try choose shortcut that you think might not be used elsewhere)

      &nbsp;
  
      * To test if shortcut works, bring window of the app, that you are trying to automate (here, Brave Browser), to focus. Try shortcut. If nothing happens, go back under `General`, and repeat with another shortcut. This might take many tries to get expected response.
      &nbsp;
      
6. **At this point, in ideal case, by pressing shortcut the expected outcome is that UI automation will run.**

      &nbsp;

Now, if above approach worked, `enable.applescript` can be done similarly (some other shortcut could be attached to it). 

```
PS! The shortcuts could be, for example: Ctrl-Cmd-Alt-' to block; Shift-Ctrl-Cmd-Alt-' to allow.
```