#Requires AutoHotkey v2.0
#SingleInstance force

; Setting hotkeys
 Volume_Up::VolumeUp()
 Volume_Down::VolumeDown()
 Volume_Mute::VolumeMute()

; Setting global variables
; ============================================================
; These variables I don't recomend changeing unless you know what your doing
; Even then there really shouldn't really be a reason to change these
; ------------------------------------------------------------
;	 Setting screen variables
	Screen_Width := Round(A_ScreenWidth)
	Screen_Height := Round(A_ScreenHeight)
	
;	 Some Information variables
	Volume := Round(SoundGetVolume())

; These are the only variables that I can recomend you change without breaking too much
; ------------------------------------------------------------
;	 Setting slider properties 
	BarHeight := 5
	BarWidth := 200
	BarXlocation := Screen_Width/2 - BarWidth*0.65
	BarYlocation := Screen_Height - 16 * BarHeight
	BarColor := "F38064"
	BarMillisecondsToStayOnScreen := 3000 

;	 Setting Volume Increment
	VolumeIncrement := 5

;	 Setting icon paths
	TrayIcon := ".\VolumeControlTrayIcon.png"
	VolumeSymbol := ".\VolumeSymbol.png"
	MuteSymbol := ".\MuteSymbol.png"
	
;	 Setting the name of the program
	ProgramName := "Volume Control"

;	 Setting variables that set the syle of the GUI
	BackGoundColor := "2C2C2C"
	FontColor := "FFFFFF"
	FontSize := 10

;	 Setting variables that set the syle of the icons
	IconsXlocation := "+3"
	IconsYlocation := "m"
	IconsWidth := "30"
	IconsHeight := "-1"
	
;	 Setting variables that set the syle of the volume slider
	SliderXlocation :=
	SliderYlocation :=
	SliderWidth :=
	SliderHeight :=
	
;	 Setting variables that set the syle of the volume number
	VolValXlocation :=
	VolValYlocation :=
	VolValWidth :=
	VolValHeight :=
	
	
; I Really don't recomend changeing these as it could break the whole GUI.
; ------------------------------------------------------------
;	 Creating and styling the GUI
	MyGui := Gui()
	MyGui.Opt("-SysMenu -DPIScale +AlwaysOnTop")
	MyGui.BackColor := BackGoundColor
	MyGui.SetFont("c" . FontColor . " s" . FontSize)
	MyGui.Hide

;	 Creating and styling the icons
	VolumeIcon := MyGui.Add("Picture", "x" . IconsXLocation . " y" . IconsYlocation . " w" . IconsWidth . " h" . IconsHeight, VolumeSymbol)

;	 Creating and styling the volume slider
	VolumeBar := MyGui.Add("Progress", "ym+6 w100 h10 cF38064 vBarVal Background9F9F9F", 75)


;	 Creating and styling the volume number
	VolumeLevel := MyGui.Add("Text" ,"x+20 ym-2 w200", Volume)


; These are the functions/scripts
; ============================================================
; These ones are for the hotkeys
; ------------------------------------------------------------

VolumeUp(){
	SoundSetMute 0
	VolumeIcon.Value := VolumeSymbol					
	SoundSetVolume "+" . VolumeIncrement
	SetTimer(SliderOff, BarMillisecondsToStayOnScreen)
	DisplaySlider()
}

VolumeDown() {
	SoundSetMute 0
	VolumeIcon.Value := VolumeSymbol
	SoundSetVolume "-" . VolumeIncrement
	SetTimer(SliderOff, BarMillisecondsToStayOnScreen)
	DisplaySlider()
}

VolumeMute() {
	CurrentMuteStatus := SoundGetMute()
	if (CurrentMuteStatus = 0) {
		SoundSetMute 1
		VolumeIcon.Value := MuteSymbol
	}
	else if (CurrentMuteStatus = 1) {
		SoundSetMute 0
		VolumeIcon.Value := VolumeSymbol
	}
	SetTimer(SliderOff, BarMillisecondsToStayOnScreen)
	DisplaySlider()
	Return
}

; These are functions/scripts that control the gui
; ------------------------------------------------------------

	SliderOff() {
		MyGui.Hide()
	}

	DisplaySlider() {
		MyGui.Show()
		WinSetStyle "-0xC00000", "A"
		MyGui.Move(BarXlocation, BarYlocation)
		MyGui.Move( , , 245, 50)
		UpdateSlider()
	}

	UpdateSlider() {
		global Volume := Round(SoundGetVolume())
		VolumeBar.Value := Volume
		VolumeLevel.Value := Volume
	}	