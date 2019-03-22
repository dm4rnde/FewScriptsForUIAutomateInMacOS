## Allow to duplicate current tab with one shortcut


| CATEGORY 		| PROGRAM | STATUS 	 |
| :------------ | :--------------| :---------|
| UI automation | Brave Browser  | **WORKS** |


&nbsp;

```
Note! With few modifications, same approach could be applied to (and reused with) other 
Chromium-based browsers.
```

&nbsp;

### Problem

##### DESCRIPTION

*Brave Browser* does not have shortcut to **duplicate currently opened tab** **with keyboard shortcut**.

*Here, duplicate means *true* duplicate — the result should be exactly as it is when selecting Duplicate from context menu opened when right-clicking on the tab's header.* 

&nbsp;

##### PROCEDURE

At the moment, to change value from existing to intended: 

| you> | <program |
| :------------ | :--------------| 
| 1. move mouse pointer to the tab (title area) and right-click on it, which | brings up the context menu |
| 2. then move mouse to item Duplicate (on that opened context menu) and click on it, which in order | opens another tab that is exactly like previous (clone of previous; includes previous's history) |

&nbsp;

### Solution

##### DESCRIPTION

Script [`duplicate.applescript`] will do UI automation (will go through mentioned steps 1. to 2.).

&nbsp;

##### PROCEDURE

| you> | UI automation script> | <program | 
| :------------ | :--------------| :--------------|  
| 1. press shortcut, which will trigger | 1. ... **brings up context menu on tab's title area** ... | brings up the context menu |
|| 2. ... **move to item Duplicate and press enter** ... | opens another tab that is exactly like previous | 

&nbsp;

### Specifics (environment)

- **AppleScript** 2.7
- **Brave Browser** 0.61.51 Chromium: 73.0.3683.75 (Official Build) (64-bit)
- **macOS** 10.13.6

&nbsp;

### Limitations

- run time (~7s); see ISSUE #1
- can't interrupt and use any UI, while AppleScript is running

&nbsp;

### Issues

- ISSUE #1: unfortunately, for some reasons, after execution of '`perform action "AXShowMenu"`', the flow stalls for ~5s

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
script. Additionally, especially when not done before, it might not go as smoothly as that.
```

1. **Convert applescript to an app**
    * Open `duplicate.applescript` file in '`Script Editor.app`' 
    * `File>Export...`
    * under '`File Format`' select `Application`
    * save as `duplicateCurrTabBraveBrowser.app` (this file name is just an example, you can name as you prefer) to 'location A'
    * you can now close `duplicate.applescript`
      &nbsp;
      
2. **Give your app Accessibility permission**; without this, app will not run
    * Go to `'System Preferences'>'Security and Privacy'>Privacy>Accessibility`
    * add `duplicateCurrTabBraveBrowser.app` (from 'location A') to that allowed list there
      &nbsp;
      
3. **Create a service that will launch your app**
    * Open `Automator.app`
    * `File>New...`
    * select `Service`
    * change first drop down to '`no input`'
    * and second drop down to '`Brave Browser.app`' ('`any application`' could also work)
    * leave the other settings as they are
    * search for '`Launch Application`'
    * double-click on '`Launch Application`', box-like area opens
    * from that box-like area open drop-down and choose '`Other...`', then browse to select `duplicateCurrTabBraveBrowser.app` (from 'location A')
    * save — here, will save this new service as `serviceToDuplicateCurrTabBraveBrowser`
    * you can now close `Automator.app`
      &nbsp;
      
4. **Attach a shortcut to your service**
    * Go to `'System Preferences'>Keyboard>Shortcuts>Services>General`
    * `serviceToDuplicateCurrTabBraveBrowser` should be listed there
    * there, for `serviceToDuplicateCurrTabBraveBrowser`
      * just on the left of the service name check `✓` the checkbox
      * on the right of the service click on `none` (or `Add Shortcut`) to **set shortcut** (try choose shortcut that you think might not be used elsewhere)

      &nbsp;
  
      * To test if shortcut works, bring window of the app, that you are trying to automate (here, Brave Browser), to focus. Try shortcut. If nothing happens, go back under `General`, and repeat with another shortcut. This might take many tries to get expected response.
      &nbsp;
      
5. **At this point, in ideal case, by pressing shortcut the expected outcome is that UI automation will run.**

      &nbsp;

