#Persistent
#NoEnv
#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%
IniFile := "settings.ini"

IniRead, Latitude, %IniFile%, Settings, Latitude, YOUR_LATITUDE
IniRead, Longitude, %IniFile%, Settings, Longitude, YOUR_LONGITUDE
IniRead, Keep, %IniFile%, Settings, Keep, 0
IniRead, Destination, %IniFile%, Settings, Destination
IniRead, XPosition, %IniFile%, Settings, XPosition, 0
IniRead, YPosition, %IniFile%, Settings, YPosition, 0

Gui, Add, Text,, Latitude:
Gui, Add, Edit, vLatitude ym w200, %Latitude%
Gui, Add, Text,, Longitude:
Gui, Add, Edit, vLongitude w200, %Longitude%
Gui, Add, Text,, Keep Weather Logs (1 = Yes, 0 = No):
Gui, Add, Edit, vKeep w200, %Keep%
Gui, Add, Text,, Destination (leave empty for script location):
Gui, Add, Edit, vDestination w200, %Destination%
Gui, Add, Text,, X Position on Screen:
Gui, Add, Edit, vXPosition w200, %XPosition%
Gui, Add, Text,, Y Position on Screen:
Gui, Add, Edit, vYPosition w200, %YPosition%
Gui, Add, Button, Default, Save Settings
Gui, Show, w400, Weather Widget Setup
Return

ButtonSaveSettings:
Gui, Submit
IniWrite, %Latitude%, %IniFile%, Settings, Latitude
IniWrite, %Longitude%, %IniFile%, Settings, Longitude
IniWrite, %Keep%, %IniFile%, Settings, Keep
IniWrite, %Destination%, %IniFile%, Settings, Destination
IniWrite, %XPosition%, %IniFile%, Settings, XPosition
IniWrite, %YPosition%, %IniFile%, Settings, YPosition
MsgBox, Settings saved to %IniFile%!
Gui, Destroy
ExitApp

GuiClose:
ExitApp