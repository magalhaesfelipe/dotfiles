#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Request admin privileges if not already elevated
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"  ; Restart script as admin
    ExitApp  ; Exit current script instance
}

; ---- ScrollLock indicator ----
Gui, SL:New, +AlwaysOnTop -Caption +ToolWindow +E0x20 +LastFound
Gui, SL:Color, 1E1E1E
Gui, SL:Font, s14 bold cLime, Segoe UI
Gui, SL:Add, Text, ,###
WinSet, Transparent, 220
Gui, SL:Show, x20 y20 NoActivate Hide

SetTimer, UpdateIndicator, 100
return

UpdateIndicator:
    if GetKeyState("ScrollLock", "T")
        Gui, SL:Show, NoActivate
    else
        Gui, SL:Hide
return

; We remap CapsLock to ScrollLock with powertoys, to avoid
; capital case mistyping when toggling navigation mode(h,j,k,l)
; KEYBINDINGS:
#If GetKeyState("ScrollLock", "T")
	h::Send, {Left}
	j::Send, {Down}
	k::Send, {Up}
	l::Send, {Right}
	w::Send, ^{Right}  ; jump to start of word
	b::Send, ^{Left} ; jump to end of word
#If

; Windows Key + I = Windows Key + Up Arrow (single press)
#i::
    SendInput, {LWin Down}{Up Down}
    SendInput, {Up Up}{LWin Up}
return

; Windows Key + K = Windows Key + Down Arrow (single press)
#k::
    SendInput, {LWin Down}{Down Down}
    SendInput, {Down Up}{LWin Up}
return

; Emojis:
:*:skull`t::💀
:*:cry`t::😭
:*:demon`t::😈
:*:badass`t::😎
:*:peaceout`t::😎✌️
:*:cold`t::🥶
:*:red`t::🟥
:*:ok`t::👍
:*:fire`t::🔥
