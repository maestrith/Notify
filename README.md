# Notify
Usage:

```
Notify:=Notify()

Window:=Notify.AddWindow("Your Text Here",{Icon:4,Background:"0xAA00AA"})
```
Window ID will be used when making calls to
```
Notify.SetProgress(Window,ProgressValue)
```

# Options:
Option|Usage|Description
------|-----|-----------
Animate|{Animate:"Bottom,Left"}|Ways that the window will animate in. Can be Bottom, Top, Left, Right, Slide, Center, or Blend (Some work together, and some override others)
Background|{Background:"0xAA00AA"}|Color value in quotes
Color|{Color:"0xAAAAAA"}|Font color
Flash|{Flash:1000}|Flashes the background of the notification every X ms
FlashColor|{FlashColor:"0xFF00FF"}|Sets the second color that your notification will change to when flashing
Font|{Font:"Consolas"}|Face of the message font
Icon|{Icon:"C:\Windows\HelpPane.exe,2"}|Can be either an Integer to pull an icon from Shell32.dll or a full path to an EXE or full path to a dll.  You can add a comma and an integer to select an icon from within that file eg. 
IconSize|{IconSize:20}|Width and Height of the Icon
Progress|{Progress:10}|Adds a progress bar ;Starts with the progress set to 10%
Radius|{Radius:10}|Size of the border radius
Size|{Size:20}|Size of the message text
Sound|{Sound:500}|Plays either a beep if the item is an integer or the sound file if it exists
Time|{Time:2000}|Sets the amount of time that the notification will be visible
Title|{Title:"This is my title"}|Sets the title of the notification
TitleColor|{TitleColor:"0xAAAAAA"}|Title font color
TitleFont|{TitleFont:"Consolas"}|Face of the title font
TitleSize|{TitleSize:12}|Size of the title text
