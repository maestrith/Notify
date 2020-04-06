# Notify
Usage:

```Notify:=Notify()

Window:=Notify.AddWindow("Your Text Here",{Icon:4,Background:"0xAA00AA"})
```

# Options:

Window ID will be used when making calls to Notify.SetProgress(Window,ProgressValue)

Icon: Can be either an Integer to pull an icon from Shell32.dll or a full path to an EXE or full path to a dll.  You can add a comma and an integer to select an icon from within that file eg. {Icon:"C:\Windows\HelpPane.exe,2"}

IconSize: Width and Height of the Icon eg. {IconSize:20}

Background: Color value in quotes eg. {Background:"0xAA00AA"}

Color: Font color eg.{Color:"0xAAAAAA"}

Title: Sets the title of the notification eg. {Title:"This is my title"}

TitleColor: Title font color eg. {TitleColor:"0xAAAAAA"}

TitleSize: Size of the title text eg. {TitleSize:12}

TitleFont: Face of the title font eg. {TitleFont:"Consolas"}

Font: Face of the message font eg. {Font:"Consolas"}

Size: Size of the message text eg {Size:20}

Radius: Size of the border radius eg. {Radius:10}

Animate: Ways that the window will animate in eg. {Animate:""} Can be Bottom, Top, Left, Right, Slide, Center, or Blend (Some work together, and some override others)

Progress: Adds a progress bar eg. {Progress:10} ;Starts with the progress set to 10%

Flash: Flashes the background of the notification every X ms eg. {Flash:1000}

FlashColor: Sets the second color that your notification will change to when flashing eg. {FlashColor:"0xFF00FF"}

Time: Sets the amount of time that the notification will be visible eg. {Time:2000}

Sound: Plays either a beep if the item is an integer or the sound file if it exists eg. {Sound:500}
