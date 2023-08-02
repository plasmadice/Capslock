;;;;;;;;; Auto Execute Section - DO NOT EDIT! ;;;;;;;;;;
#WinActivateForce ; Don't edit this: https://www.autohotkey.com/docs/v2/lib/_WinActivateForce.htm
SetCapsLockState, AlwaysOff ; Makes it so that Capslock is "always" off
SetStoreCapslockMode, Off ; Makes it so that capslock is not automatically toggled when triggering a keybind
; https://www.autohotkey.com/docs/v1/lib/SetStoreCapslockMode.htm

;;;;;;;;;;;;;;; Config ;;;;;;;;;;;;;;;
ModifyAlt := true ; Causes Alt to behave similar to the Command key on macOS
EnableCapsLock := true ; Enables Capslock as a modifier

;; The below settings are disabled if EnableCapsLock is false or 0
EnableCapsLockAlt := true ; Enables Capslock + Alt as a modifier
; EnableCapsLockWin := false ; Adds mouse controls when holding Capslock + Windows key - Disabled until I find solution to Windows key
;;;;;;;;;;;; End Config ;;;;;;;;;;;;;;

; Tips: Windows Only
; 1. Install autohotkey 2 from https://www.autohotkey.com/
; 2. Run this script by double clicking on it

; Hotkey Resource: https://www.autohotkey.com/docs/v1/Hotkeys.htm#Symbols
; Symbol Legend - [#, ^, !, +] are modifiers
; # = Windows Key
; ^ = Ctrl
; ! = Alt
; + = Shift

; Basic explanation
; ModifyAlt: Enables Alt to behave simililarly to the Command key on macOS
; EnableCapsLock: Disables CapsLock. Makes CapsLock trigger Escape if it's released without pressing anything else. Creates a new layer on your keyboard when Capslock is held down. Adds keybinds to Capslock + [key] to trigger the keybinds below.

; Possible future additions:
; 1. Add mouse controls when holding Capslock + Windows key
; 2. Alt + Click to Ctrl + Click ??

;;;;;;;;;; DO NOT EDIT BELOW THIS LINE ;;;;;;;;;;

; Experimental. Command simulation using Alt key.
#if (ModifyAlt = true)
    !Backspace::Send +{Home}+{Home}{BackSpace} ; Delete till line head
    !s::Send, {AltUp}^{s}{AltDown} ; Save
    !a::Send, {AltUp}^{a}{AltDown} ; Select All
    !c::Send, {AltUp}^{c}{AltDown} ; Copy
    !v::Send, {AltUp}^{v}{AltDown} ; Paste
    !x::Send, {AltUp}^{x}{AltDown} ; Cut
    !z::Send, {AltUp}^{z}{AltDown} ; Undo
    !+z::Send, {AltUp}^+{z}{AltDown}{ShiftDown} ; Redo
    !f::Send, {AltUp}^{f}{AltDown} ; Find
    !h::Send, {AltUp}^{h}{AltDown} ; History
    !y::Send, {AltUp}^{h}{AltDown} ; History
    !n::Send, {AltUp}^{n}{AltDown} ; New
    !o::Send, {AltUp}^{o}{AltDown} ; Open
    !l::Send, {AltUp}^{l} ;{AltDown} Go to address bar
    !p::Send, {AltUp}^{p}{AltDown}{ShiftDown} ;{AltDown} Print / Open file in VSCode
    !+p::Send, {AltUp}^+{p}{ShiftDown} ; Command Palette in VSCode
    !w::Send, {AltUp}^{w}{AltDown} ; Close
    !t::Send, {AltUp}^{t}{AltDown} ; New Tab
    !+t::Send, {AltUp}^+{t}{AltDown}{ShiftDown} ; Reopen Tab
    !q::Send, {AltUp}!{F4}{AltDown} ; Quit
    !+w::Send, {AltUp}!{F4}{AltDown}{ShiftDown} ; Quit
    !m::Send, {AltUp}#{Down 2}{AltDown} ; Minimize window
    ![::Send, {AltUp}^{[}{AltDown} ; Outdent line
    !]::Send, {AltUp}^{]}{AltDown} ; Indent line

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

*CapsLock::
    KeyWait, CapsLock
    IF A_ThisHotkey = *CapsLock
        ; #If (GetKeyState("CapsLock", "T"))
        ; Send, {CapLock Up}
        ;     SetCapsLockState, Off
        ;     Return
        ; #If
        Send, {Escape} ; Press escape if Capslock is pressed and released without any other key
Return
+Capslock::Capslock ; Press Shift + Capslock to toggle Capslock

#if (EnableCapsLock = true and GetKeyState("CapsLock", "P") and not GetKeyState("LAlt", "P") and not GetKeyState("LWin", "P")) ; Start of Capslock modifier
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
    ; App Shortcuts 
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
    LAlt:: return 
    LAlt Up:: return

    LWin::return
    LWin Up::return
#if ; End of Capslock modifier

; Alt Modifier
#if (EnableCapsLock = true and EnableCapsLockAlt = true and GetKeystate("CapsLock", "P") and GetKeyState("LAlt", "P") and not GetKeyState("LWin", "P"))

    ;
    ;
    ; Alt Cursor Movement
    h::+Left ; Select Left
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
#if (EnableCapsLock = true and EnableCapsLockWin = true and GetKeystate("CapsLock", "P") and GetKeyState("LWin", "P") and not GetKeyState("LAlt", "P"))
    ;
    ;
    ; Win Mouse Control
    ; TODO: Find solution to Capslock + Win + L locking Windows
    o::Send, {LWinUp}{XButton1}
    p::Send, {LWinUp}{XButton2}
    ; i::Send, {LWinUp}{Click Right}
    ; u::Send, {LWinUp}{Click Left}

    ;
    ;
    ; Window Control
    ; h::Send, {LWinUp}#{Left}
    ; j::Send, {LWinUp}#{Down}
    ; k::Send, {LWinUp}#{Up}
    ; l::Send, {LWinUp}#{Right}
    ; u::Send, {LWinUp}#{Up 2}

#if ; End of Win modifier