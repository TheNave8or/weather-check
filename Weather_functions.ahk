;;Performance and settings
#Include, JSON.ahk
#KeyHistory 0
#SingleInstance, Force
#MaxHotkeysPerInterval 99000000
DetectHiddenWindows, On
SetTitleMatchMode, 2
SetKeyDelay, -1, -1
SetBatchLines, -1
ListLines Off
Process, Priority, , A
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
global latitude
global longitude
global keepfile
global Destination
global xpos
global ypos
IniRead, latitude, settings.ini, Settings, Latitude
IniRead, longitude, settings.ini, Settings, Longitude
IniRead, keepfile, settings.ini, Settings, Keep
IniRead, Destination, settings.ini, Settings, Destination
If (Destination != "")
    Destination .= "\"
IniRead, xpos, settings.ini, Settings, XPosition
IniRead, ypos, settings.ini, Settings, YPosition
SetWorkingDir, %A_ScriptDir%\Assets
;;Functions

;Returns an object with the details of the weather
UpdateWeather()
{
   link = https://api.open-meteo.com/v1/forecast?latitude=%latitude%&longitude=%longitude%&current=temperature_2m,apparent_temperature,weather_code,cloud_cover&daily=weather_code,temperature_2m_max,temperature_2m_min,sunset,daylight_duration,precipitation_probability_max&timezone=auto&forecast_days=3&forecast_hours=6
   FormatTime, Time,, dddd dd.MM.yyyy
   UrlDownloadToFile, %link%, %Destination%Weather %Time%.json
	; sleep 100 ; - add if not working
   FileRead, Data, %Destination%Weather %Time%.json
   If (!keepfile)
    FileDelete, %Destination%Weather %Time%.json
   Data := JSON.Load(Data)
   Return Data
}

; Returns the color based on the temperature
CheckColor(temp)
{
  If (temp <= 10)
    Return "FCF14F" ; freezing
  Else If (temp >= 10 and temp < 23)
    Return GetColorBasedOnGradient("0xFCF14F", "0xFFED27", 10, 23, temp) ; white to bright yellow
  Else If (temp >= 23 and temp < 45)
    Return GetColorBasedOnGradient("0xFFED27", "0xFF1919", 23, 45, temp) ; orange to red
  Else If (temp >= 45)
    Return "FF1919"
}

;Gets a color based on where on the gradient it is.
GetColorBasedOnGradient(startColor, endColor, startTemp, endTemp, temperature) {
  startR := (startColor >> 16) & 0xFF
  startG := (startColor >> 8) & 0xFF
  startB := startColor & 0xFF
  endR := (endColor >> 16) & 0xFF
  endG := (endColor >> 8) & 0xFF
  endB := endColor & 0xFF
  normalizedTemp := (temperature - startTemp) / (endTemp - startTemp)
  interpolatedR := Round(startR + (endR - startR) * normalizedTemp)
  interpolatedG := Round(startG + (endG - startG) * normalizedTemp)
  interpolatedB := Round(startB + (endB - startB) * normalizedTemp)
  interpolatedColor := Format("{:02X}{:02X}{:02X}", interpolatedR, interpolatedG, interpolatedB)
  return interpolatedColor
}

;Gets tomorrow's date
TomorrowDate(GetYear := False) {
	today = %a_now%
	today += +1, days
	If (GetYear)
		FormatTime, today, %today%, dd/M/yy
	Else
		FormatTime, today, %today%, dd/M
	If (InStr(today, "0") = 1)
		today := StrReplace(today, "0")
	return today
}

;Gets tomorrow's name based on today
TomorrowName()
{
   Switch A_DDD
   {
      case "Sun":
         Return "Mon"
      case "Mon":
         Return "Tue"
      case "Tue":
         Return "Wed"
      case "Wed":
         Return "Thu"
      case "Thu":
         Return "Fri"
      case "Fri":
         Return "Sat"
      case "Sat":
         Return "Sun"
   }
}

;Returns the rain chance in words
RainChance(rainchance) {
   if (rainchance >= 0 and rainchance < 10) {
       return "no chance"
   } else if (rainchance >= 10 and rainchance < 30) {
       return "low chance"
   } else if (rainchance >= 30 and rainchance < 50) {
       return "some chance"
   } else if (rainchance >= 50 and rainchance < 70) {
       return "moderate chance"
   } else if (rainchance >= 70 and rainchance < 90) {
       return "high chance"
   } else if (rainchance >= 90 and rainchance <= 100) {
       return "very high chance"
   }
}

;Translates the cloud coverage % to a description
CloudCoverage(percentage) {
   if (percentage >= 0 and percentage <= 15) {
       return "Clear"
   } else if (percentage > 15 and percentage <= 30) {
       return "Partly Cloudy"
   } else if (percentage > 30 and percentage <= 70) {
       return "Cloudy"
   } else if (percentage > 70 and percentage <= 100) {
       return "Overcast"
   }
}

;Returns a corresponding image based on the weather code
GetWeatherImage(code) {
   switch (code) {
       case 0:
		 Image = clear.png
       case 1, 2, 3:
		 Image = partly cloudy.png
       case 45, 48:
		 Image = fog.png
       case 51, 53, 55:
		 Image = rain.png
       case 56, 57:
		 Image = rain.png
       case 61, 63, 65:
		 Image = heavy rain.png
       case 66, 67:
		 Image = thunderstorm.png
       case 71, 73, 75:
		 Image = thunderstorm.png
       case 77:
		 Image = thunderstorm.png
       case 80, 81, 82:
		 Image = heavy rain.png
       case 85, 86:
		 Image = thunderstorm.png
       case 95:
		 Image = heavy rain.png
       case 96, 99:
		 Image = thunderstorm.png
   }
	Return Image
}

;Returns a description of the weather by its weather code (WMC)
GetWeatherDescription(code) {
   switch (code) {
       case 0:
           return  "Clear skies"
       case 1, 2, 3:
           return "Partly cloudy"
       case 45, 48:
           return "Foggy"
       case 51, 53, 55:
           return "Light Drizzle"
       case 56, 57:
           return "Light cold drizzle"
       case 61, 63, 65:
           return "Moderate rain"
       case 66, 67:
           return "Heavy cold rain"
       case 71, 73, 75:
           return "Slight snow fall"
       case 77:
           return "Snow grains"
       case 80, 81, 82:
           return "Violent rain"
       case 85, 86:
           return "Snow showers"
       case 95:
           return "Slight thunderstorm"
       case 96, 99:
           return "Thunderstorm"
   }
}