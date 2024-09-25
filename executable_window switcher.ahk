#Persistent
SetTitleMatchMode, 2

OpenProgram(program, doClick := false)
{
    IfWinExist, ahk_exe %program%
    {
        ; Activate the window and wait until it is ready
        WinActivate, ahk_exe %program%
        ; Wait for the window to become active
        WinWaitActive, ahk_exe %program%, , 2  ; Timeout of 2 seconds, adjust if needed

        ; Optional: Use a loop to ensure the window is fully ready
        Loop
        {
            Sleep, 50  ; Wait for 100 milliseconds
            IfWinActive, ahk_exe %program%
            {
                ; Perform a click if needed
                if (doClick)
                {
                    Click
                }
                break
            }
        }
    }
    else
    {
        ; If the program is not open, start a new instance
        Run, %program%
    }
}

; Ubuntu
!+^U:: ; Ctrl+Alt+Shift+U
OpenProgram("C:\Program Files\WindowsApps\CanonicalGroupLimited.Ubuntu_2204.3.49.0_x64__79rhkp1fndgsc\ubuntu.exe", true)
return


;Edge
!+^E:: ; Ctrl+Alt+Shift+E
OpenProgram("msedge.exe")
return

;Arc(Browser)
!+^B:: ; Ctrl+Alt+Shift+B
OpenProgram("C:\Program Files\WindowsApps\TheBrowserCompany.Arc_1.20.0.50631_x64__ttt1ap7aakyb4\Arc.exe")
return

;Chrome
!+^C:: ; Ctrl+Alt+Shift+C
OpenProgram("C:\Program Files\Google\Chrome\Application\chrome.exe")
return

!Space:: ; Alt+Space hotkey
Send, {Alt down}{Ctrl down}{Shift down}{r down}
Sleep, 10  ; Wait for a short moment (10 milliseconds)
Send, {r up}{Shift up}{Ctrl up}{Alt up}
return

^!+q:: ; Ctrl+Alt+Shift+q
winclose, a
return

; Show a tooltip notification at the bottom center of the screen where the mouse is located when Caps Lock is toggled
!+^p:: ; Ctrl+Alt+Shift+p
{
    SetCapsLockState, % (GetKeyState("CapsLock", "T") ? "Off" : "On")
        Sleep 50  ; Optional: Give some time for Caps Lock to toggle
        ; Check the state of Caps Lock
        if GetKeyState("CapsLock", "T")
        {
msg := "CAPS LOCK - ON"
         SoundBeep, 500, 150  ; 500 Hz for 150 milliseconds
         SoundBeep, 1000, 250  ; 1000 Hz for 150 milliseconds
        }
        else
        {
msg := "CAPS LOCK - OFF"
         SoundBeep, 1000, 150  ; 500 Hz for 150 milliseconds
         SoundBeep, 500, 150  ; 1000 Hz for 150 milliseconds
         SetTimer, RemoveToolTip, 1500
        }
    ShowTooltipAtMouseScreenBottomCenter(msg)
}
return

ShowTooltipAtMouseScreenBottomCenter(text)
{
    ; Get mouse position
        MouseGetPos, MouseX, MouseY, MouseScreen

        ; Get screen dimensions where the mouse is located
        SysGet, MonitorCount, MonitorCount
        Loop, %MonitorCount%
        {
            SysGet, Monitor, Monitor, %A_Index%
                if (MouseX >= MonitorLeft and MouseX <= MonitorRight and MouseY >= MonitorTop and MouseY <= MonitorBottom)
                {
ScreenWidth := MonitorRight - MonitorLeft
                 ScreenHeight := MonitorBottom - MonitorTop
                 ; Calculate tooltip position
                 TooltipWidth := 300  ; Adjust as needed
                 TooltipHeight := 150  ; Adjust as needed
                 X := MonitorLeft + (ScreenWidth // 2) - (TooltipWidth // 2)
                 Y := MonitorBottom - TooltipHeight - 100
                 ; Show tooltip
                 ToolTip, %text%, %X%, %Y%
                 break
                }
        }
}

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return
