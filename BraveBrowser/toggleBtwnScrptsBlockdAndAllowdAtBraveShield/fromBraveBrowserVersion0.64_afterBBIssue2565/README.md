## Toggle 'Scripts blocked' (under Brave Shield, under Brave Browser)


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

*Brave Browser* does not have option to **toggle on/off 'Scripts blocked'**  **with keyboard shortcut**. 

*'Scripts blocked' toggle refers to the part under 'Brave Shields' where user can block JavaScript scripts from running — or instead, allow them to run — on domain of currently opened page/url.*

*(Other, but not that relevant anymore, sidenote:
https://github.com/brave/brave-browser/issues/3717)*

&nbsp;

##### PROCEDURE

At the moment, to change value from existing to intended: 

| you> | <program |
| :------------ | :--------------| 
| 1. move mouse pointer to click on the 'lion icon' located on the right (on the 'address bar'), which | brings up the 'Brave Shields' box |
| 2. then move mouse to go to certain toggle element and click on it, and wait a bit to allow | toggle changes its value | 
| 3. finally press escape key on keyboard (or move mouse away to some neutral area and click), which | closes the 'Brave Shields' |

&nbsp;

### Solution

##### DESCRIPTION

Script [`toggle.applescript`] will do UI automation (will go through mentioned steps 1. to 3.), and based on current state of toggle, will:

- change toggle of '**Scripts blocked**' to off when it was on (now 'all scripts are allowed to run')

- change toggle of '**Scripts blocked**' to on when it was off (now 'all scripts are blocked')

&nbsp;

##### PROCEDURE

| you> | UI automation script> | <program | 
| :------------ | :--------------| :--------------|  
| 1. press shortcut, which will trigger | 1. ... **click on the 'lion icon'** ... | brings up the 'Brave Shields' box |
|| 2. ... **move mouse to ... certain toggle element and click on it** ... | toggle changes its value | 
|| 3. **finally press escape key** ... | closes the 'Brave Shields' |

&nbsp;

### Specifics (environment)

- **AppleScript** 2.7
- **Python** 2
- **Brave Browser** 0.66.101 Chromium: 75.0.3770.142 (Official Build) (64-bit)
- **macOS** 10.13.6

&nbsp;

### Limitations

- run time (~3s)
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
        
2. **Convert toggleCaller.applescript to an app**
    * Open `toggleCaller.applescript` file in '`Script Editor.app`' 
    * `File>Export...`
    * under '`File Format`' select `Application`
    * save as `toggleScrptsBlockdForCurrPgBraveShieldBraveBrowser.app` (this file name is just an example, you can name as you prefer) to 'location A'
    * you can now close `toggleCaller.applescript`
      &nbsp;
      
3. **Give your app Accessibility permission**; without this, app will not run
    * Go to `'System Preferences'>'Security and Privacy'>Privacy>Accessibility`
    * add `toggleScrptsBlockdForCurrPgBraveShieldBraveBrowser.app` (from 'location A') to that allowed list there
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
    * from that box-like area open drop-down and choose '`Other...`', then browse to select `toggleScrptsBlockdForCurrPgBraveShieldBraveBrowser.app` (from 'location A')
    * save — here, will save this new service as `serviceToToggleScrptsBlockdCurrPgBraveShieldBraveBrowser`
    * you can now close `Automator.app`
      &nbsp;
      
5. **Attach a shortcut to your service**
    * Go to `'System Preferences'>Keyboard>Shortcuts>Services>General`
    * `serviceToToggleScrptsBlockdCurrPgBraveShieldBraveBrowser` should be listed there
    * there, for `serviceToToggleScrptsBlockdCurrPgBraveShieldBraveBrowser`
      * just on the left of the service name check `✓` the checkbox
      * on the right of the service click on `none` (or `Add Shortcut`) to **set shortcut** (try choose shortcut that you think might not be used elsewhere)

      &nbsp;
  
      * To test if shortcut works, bring window of the app, that you are trying to automate (here, Brave Browser), to focus. Try shortcut. If nothing happens, go back under `General`, and repeat with another shortcut. This might take many tries to get expected response.
      &nbsp;
      
6. **At this point, in ideal case, by pressing shortcut the expected outcome is that UI automation will run.**

      &nbsp;

```
PS! The shortcuts could be, for example, Shift-Ctrl-Cmd-Alt-'.
```