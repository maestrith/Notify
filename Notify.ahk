#SingleInstance,Force
Count:=0
Notify:=Notify()
/*
	Usage:
	Notify:=Notify()
	Window:=Notify.AddWindow("Your Text Here",{Icon:4,Background:"0xAA00AA"})
	|---Window ID                                          |--------Options
	Options:
	
	Window ID will be used when making calls to Notify.SetProgress(Window,ProgressValue)
	
	Animate: Ways that the window will animate in eg. {Animate:""} Can be Bottom, Top, Left, Right, Slide, Center, or Blend (Some work together, and some override others)
	Background: Color value in quotes eg. {Background:"0xAA00AA"}
	Color: Font color eg.{Color:"0xAAAAAA"}
	Flash: Flashes the background of the notification every X ms eg. {Flash:1000}
	FlashColor: Sets the second color that your notification will change to when flashing eg. {FlashColor:"0xFF00FF"}
	Font: Face of the message font eg. {Font:"Consolas"}
	Icon: Can be either an Integer to pull an icon from Shell32.dll or a full path to an EXE or full path to a dll.  You can add a comma and an integer to select an icon from within that file eg. {Icon:"C:\Windows\HelpPane.exe,2"}
	IconSize: Width and Height of the Icon eg. {IconSize:20}
	Progress: Adds a progress bar eg. {Progress:10} ;Starts with the progress set to 10%
	Radius: Size of the border radius eg. {Radius:10}
	Size: Size of the message text eg {Size:20}
	Sound: Plays either a beep if the item is an integer or the sound file if it exists eg. {Sound:500}
	Time: Sets the amount of time that the notification will be visible eg. {Time:2000}
	Title: Sets the title of the notification eg. {Title:"This is my title"}
	TitleColor: Title font color eg. {TitleColor:"0xAAAAAA"}
	TitleFont: Face of the title font eg. {TitleFont:"Consolas"}
	TitleSize: Size of the title text eg. {TitleSize:12}
*/
if(){
	Notify.AddWindow("Testing",{Background:"0xFF00FF",Color:"0xFF0000"})
	return
}
Text:=["Longer text for a longer thing","Taller Text`nfor`na`ntaller`nthing"]
SetTimer,RandomProgress,500
Loop,2
{
	/*
		Random,Time,3000,8000
	*/
	/*
		Time:=A_Index=40?1000:Time
		Random,Sound,500,800
	*/
	Random,TT,1,2
	Random,Background,0x0,0xFFFFFF
	Random,Color,0x0,0xFFFFFF
	Random,Icon,20,200
	Notify.AddWindow(Text[TT],{Icon:300,Title:"This is my title",TitleFont:"Tahoma",TitleSize:10,Time:Time,Background:Background,Flash:1000,Color:Color})
	Notify.AddWindow(Text[TT],{Icon:"D:\AHK\AHK-Studio\AHK-Studio.exe",IconSize:20,Title:"This is my title",TitleFont:"Tahoma",TitleSize:10,Time:Time,Background:Background,Flash:1000,FlashColor:"0xAA00AA",Color:Color,Time:Time,Sound:Sound})
	Notify.AddWindow(Text[TT],{Icon:Icon,IconSize:80,Title:"This is my title",TitleFont:"Tahoma",TitleSize:10,Time:Time,Background:Background,Flash:1000,FlashColor:"0xAA00AA",Color:Color,Time:Time,Sound:Sound})
	ID:=Notify.AddWindow(Text[TT],{Progress:0,Icon:Icon,IconSize:80,Title:"This is my title",TitleFont:"Tahoma",TitleSize:10,Time:Time,Background:Background,Flash:1000,FlashColor:"0xAA00AA",Color:Color,Time:Time,Sound:Sound})
	Notify.AddWindow("This is my text",{Title:"My Title"})
	Random,Ico,1,5
	Notify.AddWindow("Odd icon",{Icon:A_AhkPath "," Ico,IconSize:20,Title:"This is my title",TitleFont:"Tahoma",TitleSize:10,Time:Time,Background:Background,Flash:1000,Color:Color,Time:Time})
	Random,Delay,100,400
	Notify.AddWindow(Text[TT],{Radius:20,Animate:"Right,Slide",ShowDelay:Delay,Icon:Icon,IconSize:20,Title:"This is my title",TitleFont:"Tahoma",TitleSize:10,Time:Time,Background:Background,Color:Color,Time:Time,Progress:0})
}
return
RandomProgress:
for a,b in NotifyClass.Windows{
	Random,Pro,10,100
	Notify.SetProgress(a,Pro)
}
return
Click(Obj){
	for a,b in Obj
		Msg.=a " = " b "`n"
	MsgBox,%Msg%
}
;Actual code starts here
Notify(Margin:=5){
	return New NotifyClass()
}
Class NotifyClass{
	__New(Margin:=10){
		this.ShowDelay:=40,this.ID:=0,this.Margin:=Margin,this.Animation:={Bottom:0x00000008,Top:0x00000004,Left:0x00000001,Right:0x00000002,Slide:0x00040000,Center:0x00000010,Blend:0x00080000}
		if(!this.Init)
			OnMessage(0x201,NotifyClass.Click.Bind(this)),this.Init:=1
	}AddWindow(Text,Info:=""){
		(Info?Info:Info:=[])
		for a,b in {Background:0,Color:"0xAAAAAA",TitleColor:"0xAAAAAA",Font:"Consolas",TitleSize:12,TitleFont:"Consolas",Size:20,Font:"Consolas",IconSize:20}
			if(Info[a]="")
				Info[a]:=b
		if(!IsObject(Win:=NotifyClass.Windows))
			Win:=NotifyClass.Windows:=[]
		DetectHiddenWindows,On
		this.Hidden:=Hidden:=A_DetectHiddenWindows,this.Current:=ID:=++this.ID,Owner:=WinActive("A")
 		Gui,Win%ID%:Default
		if(Info.Radius)
			Gui,Margin,% Floor(Info.Radius/2),% Floor(Info.Radius/2)
		Gui,-Caption +HWNDMain +AlwaysOnTop +Owner%Owner%
		Gui,Color,% Info.Background,% Info.Background
		NotifyClass.Windows[ID]:={ID:"ahk_id" Main,HWND:Main,Win:"Win" ID,Text:Text,Background:Info.Background,FlashColor:Info.FlashColor,Title:Info.Title}
		if((Ico:=StrSplit(Info.Icon,",")).1)
			Gui,Add,Picture,% (Info.IconSize?"w" Info.IconSize " h" Info.IconSize:""),% "HBITMAP:" LoadPicture(Foo:=(Ico.1+0?"Shell32.dll":Ico.1),Foo1:="Icon" (Ico.2!=""?Ico.2:Info.Icon),2)
		if(Info.Title){
			Gui,Font,% "s" Info.TitleSize " c" Info.TitleColor,% Info.TitleFont
			Gui,Add,Text,x+m,% Info.Title
		}Gui,Font,% "s" Info.Size " c" Info.Color,% Info.Font
		Gui,Add,Text,HWNDText,%Text%
		SysGet,Mon,MonitorWorkArea
		if(Info.Sound+0)
			SoundBeep,% Info.Sound
		if(FileExist(Info.Sound))
			SoundPlay,% Info.Sound
		this.MonBottom:=MonBottom,this.MonTop:=MonTop,this.MonLeft:=MonLeft,this.MonRight:=MonRight
		if(Info.Time){
			TT:=this.Dismiss.Bind({this:this,ID:ID})
			SetTimer,%TT%,% "-" Info.Time
		}if(Info.Flash){
			TT:=this.Flash.Bind({this:this,ID:ID})
			SetTimer,%TT%,% Info.Flash
			NotifyClass.Windows[ID].Timer:=TT
		}if(Info.Progress!=""){
			Gui,Win%ID%:Font,s4
			ControlGetPos,x,y,w,h,,ahk_id%Text%
			Gui,Add,Progress,w%w% HWNDProgress,% Info.Progress
			NotifyClass.Windows[ID].Progress:=Progress
		}Gui,Win%ID%:Show,Hide
		WinGetPos,x,y,w,h,ahk_id%Main%
		if(Info.Radius)
			WinSet, Region, % "0-0 w" W " h" H " R" Info.Radius "-" Info.Radius,ahk_id%Main%
		Obj:=this.SetPos(),Flags:=0
		for a,b in StrSplit(Info.Animate,",")
			Flags|=Round(this.Animation[b])
		DllCall("AnimateWindow","UInt",Main,"Int",(Info.ShowDelay?Info.ShowDelay:this.ShowDelay),"UInt",(Flags?Flags:0x00000008|0x00000004|0x00040000|0x00000002))
		DetectHiddenWindows,%Hidden%
		return ID
	}Click(){
		Obj:=NotifyClass.Windows[RegExReplace(A_Gui,"\D")],(Fun:=Func("Click"))?Fun.Call(Obj):"",this.Delete(A_Gui)
	}Delete(Win){
		Win:=RegExReplace(Win,"\D")
		Obj:=NotifyClass.Windows[Win]
		NotifyClass.Windows.Delete(Win)
		Gui,% Obj.Win ":Destroy"
		if(TT:=Obj.Timer)
			SetTimer,%TT%,Off
		this.SetPos()
	}Dismiss(){
		this.this.Delete(this.ID)
	}Flash(){
		Obj:=NotifyClass.Windows[this.ID]
		Obj.Bright:=!Obj.Bright
		Color:=Obj.Bright?(Obj.FlashColor!=""?Obj.FlashColor:Format("{:06x}",Obj.Background+800)):Obj.Background
		if(WinExist(Obj.ID))
			Gui,% Obj.Win ":Color",%Color%,%Color%
	}SetPos(){
		Width:=this.MonRight-this.MonLeft,MH:=this.MonBottom-this.MonTop,MinX:=[],MinY:=[],Obj:=[],Height:=0,Sub:=0,MY:=MH,MaxW:={0:1},Delay:=A_WinDelay,Hidden:=A_DetectHiddenWindows
		DetectHiddenWindows,On
		SetWinDelay,-1
		for a,b in NotifyClass.Windows{
			WinGetPos,x,y,w,h,% b.ID
			Height+=h+this.Margin
			if(MH<=Height)
				Sub:=Width-MinX.MinIndex()+this.Margin,MY:=MH,MinY:=[],MinX:=[],Height:=h,MaxW:={0:1},Reset:=1
			MaxW[w]:=1,MinX[Width-w-Sub]:=1,MinY[MY:=MY-h-this.Margin]:=y,XPos:=MinX.MinIndex()+(Reset?0:MaxW.MaxIndex()-w)
			WinMove,% b.ID,,%XPos%,MinY.MinIndex()
			Obj[a]:={x:x,y:y,w:w,h:h},Reset:=0
		}DetectHiddenWindows,%Hidden%
		SetWinDelay,%Delay%
	}SetProgress(ID,Progress){
		GuiControl,,% NotifyClass.Windows[ID].Progress,%Progress%
	}
}
;Actual Code Ends Here
return
Escape::
ExitApp
return