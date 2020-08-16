#NoTrayIcon
#SingleInstance force

autoexecute:

	SetTimer getActiveWindow, 1000

	Gui, Add, Text   , xp+10  yp+20 , ターゲット
	Gui, Add, Edit   , xp+50  yp-3  vclassB readOnly w250
	Gui, Add, Edit   , xp+0   yp+23 vtitleB readOnly w250

	Gui, Add, Radio  , x30    yp+50 vradio0 Checked gsetRadio0  , 最前面を解除
	Gui, Add, Radio  , xp+0   yp+20 vradio1         gsetRadio1  , 常に最前面

	Gui, Add, Text   , xp+0   yp+45 , 透明度
	Gui, Add, Slider , xp+40  yp-5  w220 vslider gmoveSlider Range0-255 Page20 TickInterval64, 255
	Gui, Submit
	Gui, Add, Edit   , xp+220 yp+0  w30 vedit ginputEdit Number Limit3 , %slider%

	Gui, Add, Button , x200   yp+55 w50 gReset            , リセット
	Gui, Add, Button , x275   yp+0  w50 gGuiClose Default , 閉じる

	Gui, Submit, NoHide
	Gui, Show, W350 H250
return

getActiveWindow:
	WinGetTitle, title, A
	WinGetClass, class, A
	if(title <> A_ScriptName && title <> "Program Manager")
	{	GuiControl,, classB, %class%
		GuiControl,, titleB, %title%
	}
	Gui, Submit, NoHide
return


moveSlider:
	Gui, Submit , NoHide
	edit := slider
	GuiControl,, edit, %edit%
	if classB <>
	{	Gui, Submit , NoHide
		WinSet, Transparent, %edit% , ahk_class %classB%
	}
return

inputEdit:
	Gui, Submit , NoHide
	slider := edit
	GuiControl,, slider, %slider%
	if classB <>
	{	Gui, Submit , NoHide
		WinSet, Transparent, %edit% , ahk_class %classB%
	}
return


setRadio0:
	if classB <>
	{	WinSet, AlwaysOnTop, OFF , ahk_class %classB%
	}
return
setRadio1:
	if classB <>
	{	WinSet, AlwaysOnTop, ON , ahk_class %classB%
	}
return

reset:
	if classB <>
	{	GuiControl,, radio0, 1
		GoSub, setRadio0
		GuiControl,, edit, 255
	}
return


GuiClose:
GuiEscape:
ExitApp