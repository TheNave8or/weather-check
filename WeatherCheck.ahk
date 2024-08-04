SetWorkingDir, %A_ScriptDir%
#Include, Weather_functions.ahk
#NoTrayIcon
; ;=========================================
today := A_DD
FormatTime, Month, , M
If (InStr(A_DD, "0") = 1)
   today := StrReplace(A_DD, "0")
todaystr = %A_DDD% %today%/%Month%
tomorrowstr := TomorrowName() . " " . TomorrowDate()
Data := UpdateWeather()
tempnow := Data.current.temperature_2m Chr(0x00B0)
feelslike := Data.current.apparent_temperature Chr(0x00B0)
today_max := Chr(0x1F4C8) Data.daily.temperature_2m_max[1]
today_min := Chr(0x1F4C9) Data.daily.temperature_2m_min[1]
tomorrow_max := Chr(0x1F4C8) Data.daily.temperature_2m_max[2]
tomorrow_min := Chr(0x1F4C9) Data.daily.temperature_2m_min[2]
currentWeather := GetWeatherDescription(Data.current.weather_code)
nowimage := GetWeatherImage(Data.current.weather_code)
todayimage := GetWeatherImage(Data.Daily.weather_code[1])
tomorrowimage := GetWeatherImage(Data.Daily.weather_code[2])
sunset := SubStr(Data.Daily.sunset[1], 12)
rainchancetoday := Data.Daily.precipitation_probability_max[1] . "%"
rainchancetomorrow := Data.Daily.precipitation_probability_max[2] . "%"
maxcolor := CheckColor(Data.daily.temperature_2m_max[1])
mincolor := CheckColor(Data.daily.temperature_2m_min[1])
tomorrowmaxcolor := CheckColor(Data.daily.temperature_2m_max[2])
tomorrowmincolor := CheckColor(Data.daily.temperature_2m_min[2])
nowcolor := CheckColor(Data.current.temperature_2m)
Gui, Margin, 0, 0
Gui, +AlwaysOnTop +LastFound -Caption +Owner +ToolWindow +E0x20
Gui, Color, 131314
Gui, Font, S30 Q5, Leelawadee UI Semilight
Gui, Add, Text, vtempnow_id c%nowcolor% x0 y-10, %tempnow%
Gui, Font, S20 Q5, Segoe UI
Gui, Add, Text, vfeelslike_id cWhite x90 y5, Feels like %feelslike%
Gui, Font, S16 Q5, Leelawadee UI Semilight
Gui, Add, Text, vcurrentweather_id cWhite x50 y45, %currentWeather%
Gui, Add, Picture, x90 y80 h36 w40 HWNDtodayimage_id, %todayimage%
Gui, Add, Picture, x90 y122 h36 w40 HWNDtomorrowimage_id, %tomorrowimage%
Gui, Add, Picture, x0 y45 h36 w40 HWNDnowimage_id, %nowimage%
Gui, Add, Picture, x270 y50 h36 w40, sunset.png
Gui, Add, Text, cWhite x325 y50 vsunset_id, %sunset%
Gui, Add, Text, cWhite x0 y83 vtodaystr_id, %todaystr%
Gui, Add, Text, cWhite x0 y125 vtomorrowstr_id, %tomorrowstr%
Gui, Add, Picture, x140 y80 h35 w30, rain chance.png
Gui, Add, Text, cWhite x180 y83 vrainchancetoday_id,%rainchancetoday%
Gui, Add, Text, c%maxcolor% x233 y83 vtoday_max_id, %today_max%
Gui, Add, Text, c%mincolor% x310 y83 vtoday_min_id, %today_min%
Gui, Add, Picture, x140 y122 h35 w30, rain chance.png
Gui, Add, Text, cWhite x180 y125 vrainchancetomorrow_id, %rainchancetomorrow%
Gui, Add, Text, c%tomorrowmaxcolor% x233 y125 vtomorrow_max_id, %tomorrow_max%
Gui, Add, Text, c%tomorrowmincolor% x310 y125 vtomorrow_min_id, %tomorrow_min%
Gui, Show, x%xpos% y%ypos% w380 h160 NA
WinSet, Transparent, 205
SetTimer, UpdateWidget, 600000
Return


UpdateWidget:
today := A_DD
FormatTime, Month, , M
If (InStr(A_DD, "0") = 1)
   today := StrReplace(A_DD, "0")
todaystr = %A_DDD% %today%/%Month%
tomorrowstr := TomorrowName() . " " . TomorrowDate()
prev_nowimage := GetWeatherImage(Data.current.weather_code)
prev_todayimage := GetWeatherImage(Data.Daily.weather_code[1])
prev_tomorrowimage := GetWeatherImage(Data.Daily.weather_code[2])
Data := UpdateWeather()
tempnow := Data.current.temperature_2m Chr(0x00B0)
feelslike := Data.current.apparent_temperature Chr(0x00B0)
today_max := Chr(0x1F4C8) Data.daily.temperature_2m_max[1]
today_min := Chr(0x1F4C9) Data.daily.temperature_2m_min[1]
tomorrow_max := Chr(0x1F4C8) Data.daily.temperature_2m_max[2]
tomorrow_min := Chr(0x1F4C9) Data.daily.temperature_2m_min[2]
currentWeather := GetWeatherDescription(Data.current.weather_code)
nowimage := GetWeatherImage(Data.current.weather_code)
todayimage := GetWeatherImage(Data.Daily.weather_code[1])
tomorrowimage := GetWeatherImage(Data.Daily.weather_code[2])
sunset := SubStr(Data.Daily.sunset[1], 12)
rainchancetoday := Data.Daily.precipitation_probability_max[1] . "%"
rainchancetomorrow := Data.Daily.precipitation_probability_max[2] . "%"
maxcolor := CheckColor(Data.daily.temperature_2m_max[1])
mincolor := CheckColor(Data.daily.temperature_2m_min[1])
tomorrowmaxcolor := CheckColor(Data.daily.temperature_2m_max[2])
tomorrowmincolor := CheckColor(Data.daily.temperature_2m_min[2])
nowcolor :=CheckColor(Data.current.temperature_2m)
if (prev_nowimage != nowimage) {
   GuiControl, , %nowimage_id%, %nowimage%
}
if (prev_todayimage != todayimage) {
   GuiControl, , %todayimage_id%, %todayimage%
}
if (prev_tomorrowimage != tomorrowimage) {
   GuiControl, , %tomorrowimage_id%, %tomorrowimage%
}
GuiControl,, todaystr_id, %todaystr%
GuiControl,, tomorrowstr_id, %tomorrowstr%
GuiControl,, tempnow_id, %tempnow%
GuiControl,, feelslike_id, Feels like %feelslike%
GuiControl,, currentWeather_id, %currentWeather%
GuiControl,, sunset_id, %sunset%
GuiControl,, rainchancetoday_id, %rainchancetoday%
GuiControl,, today_max_id, %today_max%
GuiControl,, today_min_id, %today_min%
GuiControl,, tomorrow_max_id, %tomorrow_max%
GuiControl,, tomorrow_min_id, %tomorrow_min%
GuiControl,, rainchancetomorrow, %rainchancetomorrow% `%
GuiControl, +c%nowcolor%, tempnow_id
GuiControl, +c%maxcolor%, today_max_id
GuiControl, +c%mincolor%, today_min_id
GuiControl, +c%tomorrowmaxcolor%, tomorrow_max_id
GuiControl, +c%tomorrowmincolor%, tomorrow_min_id
Gui, +Owner -Caption -MaximizeBox +AlwaysOnTop +Hwndtexthwnd +LastFound +ToolWindow +E0x20
Return

!F9::ExitApp
