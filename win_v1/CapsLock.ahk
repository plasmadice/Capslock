; Tips: Windows Only
; 1. Install autohotkey 2 from https://www.autohotkey.com/
; 2. Run this script by double clicking on it

; Resources: https://www.autohotkey.com/docs/v1/Hotkeys.htm#Symbols
; Symbols - [#, ^, !, +] are modifiers
; # = Windows Key
; ^ = Ctrl
; ! = Alt
; + = Shift

; Basic explanation 
; This script creates a new layer on your keyboard when Capslock is held down

; Important!!!!
; Note that ^(ctrl) is used a lot to add an extra layer. 
; This will be changed to alt soon due to the that holding a modifier passes it to the destination key.
; https://www.autohotkey.com/docs/v1/misc/Remap.htm#remarks 

#WinActivateForce ; https://www.autohotkey.com/docs/v2/lib/_WinActivateForce.htm
SetCapsLockState, AlwaysOff

#If GetKeyState("CapsLock", "P")
Escape::CapsLock

; Movement
h::Left
j::Down
k::Up
l::Right
; Far movement
g::^Left
'::^Right
; Top / Bottom of page + Start / end of line
i::Home
o::End

; Selection
^h::+Left
^j::+Down
^k::+Up
^l::+Right
; Far movement
^g::+^Left
^'::+^Right
; Top / Bottom of page + Start / end of line 
; Not in use due to https://www.autohotkey.com/docs/v1/misc/Remap.htm#remarks
; ^i::+Home
; ^o::+End

; s = Switch Tab
s::^PgDn
^s::^PgUp

; w = Close / Reopen tab
w::^w
^t::^+t

; Deletion stuff
m::Backspace
n::^BackSpace
.::^Delete

; Backspace
Backspace::^Backspace

; Programming stuff
c::^c
v::^v
; Vim
d::^d
u::^u
:::+:
/::^/

; Programs > Focuses windows > TODO: Open window if focus fails
e::WinActivate, ahk_exe chrome.exe
t::WinActivate, ahk_exe code.exe

; Misc

#If

; Changes Capslock to a unique modifier

*CapsLock::
KeyWait, CapsLock
IF A_ThisHotkey = *CapsLock
    Send, {Escape}
Return