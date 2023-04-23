#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Process, Exist, vmware.exe
    if !ErrorLevel
    { 
        Run, "C:\Program Files (x86)\VMware\VMware Workstation\vmware.exe"
    ;    WinActivate, ahk_exe vmware.exe
    }
 ;   Else   
;    {
 ;       WinActivate, ahk_exe vmware.exe
 ;   }
Sleep 4000
       if WinExist("ahk_class VMUIFrame")
       {
        WinActivate
        Send ^l
        Send ^s 
        SendInput 192.168.0.1
        Send ^u
        SendInput root 
        Send ^p
        SendInput shnooka
        Send {Enter}
       }