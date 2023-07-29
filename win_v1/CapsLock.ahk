
; Tips: Windows Only
; 1. Install autohotkey 2 from https://www.autohotkey.com/
; 2. Run this script by double clicking on it

;;;;;;;;;;;;;;; Config ;;;;;;;;;;;;;;; 
ModifyAlt := true ; Causes Alt to behave simililarly to the Command key on macOS
ModifyWin := false ; Adds mouse controls when holding Capslock + Windows key
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Resources: https://www.autohotkey.com/docs/v1/Hotkeys.htm#Symbols
; Symbols - [#, ^, !, +] are modifiers
; # = Windows Key
; ^ = Ctrl
; ! = Alt
; + = Shift

; Basic explanation 
; This script creates a new layer on your keyboard when Capslock is held down


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Experimental. Command simulation using Alt key.
#if (ModifyAlt = true)
    !Backspace::Send +{Home}+{Home}{BackSpace} ; Delete till line head
    !s::Send, {AltUp}^{s} ; Save
    !a::Send, {AltUp}^{a} ; Select All
    !c::Send, {AltUp}^{c} ; Copy
    !v::Send, {AltUp}^{v} ; Paste
    !x::Send, {AltUp}^{x} ; Cut
    !z::Send, {AltUp}^{z} ; Undo
    !+z::Send, {AltUp}^+{z} ; Redo
    !y::Send, {AltUp}^{y} ; Redo
    !f::Send, {AltUp}^{f} ; Find
    !h::Send, {AltUp}^{h} ; Replace
    !n::Send, {AltUp}^{n} ; New
    !o::Send, {AltUp}^{o} ; Open 
    !l::Send, {AltUp}^{l} ; Go to address bar
    !p::Send, {AltUp}^{p} ; Print / Open file in VSCode
    !+p::Send, {AltUp}^+{p} ; Command Palette in VSCode
    !w::Send, {AltUp}^{w} ; Close
    !t::Send, {AltUp}^{t} ; New Tab
    !+t::Send, {AltUp}^+{t} ; Reopen Tab
    !q::Send, {AltUp}!{F4} ; Quit
    !+w::Send, {AltUp}!{F4} ; Quit
    ![::Send, {AltUp}^{[} ; Outdent line
    !]::Send, {AltUp}^{]} ; Indent line

    ; Implement cycling between same app Alt + ` = Command + ` https://superuser.com/a/1721255
    !`:: 
    WinGetClass, OldClass, A
    WinGet, ActiveProcessName, ProcessName, A
    WinGet, WinClassCount, Count, ahk_exe %ActiveProcessName%
    IF WinClassCount = 1
        Return
    loop, 2 {
    WinSet, Bottom,, A
    WinActivate, ahk_exe %ActiveProcessName%
    WinGetClass, NewClass, A
    if (OldClass <> "CabinetWClass" or NewClass = "CabinetWClass")
        break
    }
#if
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


#WinActivateForce ; https://www.autohotkey.com/docs/v2/lib/_WinActivateForce.htm

SetCapsLockState, AlwaysOff

*CapsLock::
KeyWait, CapsLock
IF A_ThisHotkey = *CapsLock
    Send, {Escape} ; Press escape if Capslock is released
Return
+Capslock::Capslock ; Press Shift + Capslock to toggle Capslock

#if (GetKeyState("CapsLock", "P") and not GetKeyState("LAlt", "P") and not GetKeyState("LWin", "P")) ; Start of Capslock modifier
Escape::CapsLock ; Press Capslock + Escape to toggle Capslock
Shift::CapsLock ; Press Capslock + Shift to toggle Capslock

;
; Cursor Movement
h::Left
j::Down
k::Up
l::Right
; Far Movement
g::^Left
'::^Right
; Top / Bottom of page + Start / end of line
i::Home
o::End

;
;
; Window Control
Tab::#Tab ; Task View
q::!F4 ; close app
w::^w ; close tab
a::Send, #{Tab} ; task view
s::^PgDn ; next tab
t::^+t ; reopen tab or window

;
;
; Text Deletion
n::^BackSpace ; Delete a word before the cursor
m::Backspace ; Delete a character before the cursor
,::Delete ; Delete a character after the cursor
.::^Delete ; Delete a word after the cursor
Backspace::^Backspace ; Delete a word before the cursor

;
;
; Terminal Control and CTRL substitute
z::^z ; CTRL + Z - Undo
x::^x ; CTRL + X - Cut
c::^c ; CTRL + C - Interrupt (SIGINT)
v::^v ; CTRL + V - Paste / Vim Prefix
b::^b ; CTRL + B - Tmux Prefix
`::^+i ; Toggle chrome dev tools
f::^f ; CTRL + F - Find

;
;
; Vim Shortcuts
r::^r ; redo
u::^u ; scroll up
d::^d ; scroll down
:::+: ; : colon
/::^/ ; comment

;
;
; App Shortcuts TODO: Currently only focuses - Open window if focus fails
e::WinActivate, ahk_exe chrome.exe
t::WinActivate, ahk_exe code.exe
; y ??
; f ??

;
;
; Mouse Control
Enter::Click Left

;
;
; Disables LAlt and LWin while Capslock is pressed
; Required to prevent the modifiers from being passed to the destination key
LAlt::
LWin::
; KeyWait, LWin
IF A_ThisHotkey = *LWin
Return

#if ; End of Capslock modifier


; Alt Only modifier
#if (GetKeystate("CapsLock", "P") and GetKeyState("LAlt", "P") and not GetKeyState("LWin", "P"))

;
;
; Alt Cursor Movement
h::+Left
j::+Down
k::+Up
l::+Right
; Alt Far Select Movement
g::+^Left
'::+^Right
; Start / End of Line 
i::+Home ; Select to Start of Line
o::+End ; Select to End of Line

;
;
; Alt Window Control
s::^PgUp ; Previous Tab
t::^+t ; Reopen Tab or Window
w::!F4 ; Close App

;
;
; Alt Text Deletion
n::Send +{Home}{BackSpace} ; Delete till line head
m::^Backspace ; Delete a word ahead
,::^Delete ; Delete a word after
.::Send +{End}{Backspace} ; Delete till line end
Backspace::Send +{End}{Backspace} ; Delete till line end

;
;
; Alt App Shortcuts

;
;
; Mouse Movements

#if ; End of Alt modifier


; Win Only modifier
#if (GetKeystate("CapsLock", "P") and GetKeyState("LWin", "P") and not GetKeyState("LAlt", "P"))

;
;
; Win Mouse Control
; TODO: Find solution to Capslock + Win + L locking Windows
o::XButton1
p::XButton2
; i::Click Right
i::Send, {LWinUp}{Click Right}
u::Send, {LWinUp}{Click Left}

#if ; End of Win modifier