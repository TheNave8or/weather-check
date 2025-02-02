# Weather-Check

This project is a customizable weather widget for Windows using AutoHotkey (AHK). It fetches weather data from the Open-Meteo API and displays it in a compact, always-on-top window on your desktop.

## Features

- **Weather Data:** Displays current temperature, feels-like temperature, weather conditions, and more.
- **Customization:** Allows changes to screen position, the option to keep or delete weather logs, and setting geographical coordinates.
- **Visuals:** Shows weather icons based on current conditions.

## Installation

### Download and Extract Files

- Download the repository and extract the files to a folder on your computer.

### Configure Settings

- **For AHK Script Users:**
    - On the first run, setup will be automatically launched.
    - After that, run the `Setup.ahk` script to set up your different settings, such as latitude, longitude, screen position, etc.
    - The settings will be saved in the `settings.ini` file.

- **For Compiled Version Users:**
    - Run `WeatherCheck_win64.exe` first to extract `weather-check` folder.
    - Setup will be automatically launched after you run `WeatherCheck_win64.exe`, and then it will rerun the widget with the updated info.
    - After that, launch `weather-check\setup.lnk` to reconfigure settings.

### Run the Widget

- **AHK Script:** Launch the main script `WeatherCheck.ahk` to start the weather widget.
- **Compiled Version:** Run `WeatherCheck_win64.exe` to start the weather widget.
- 
## Widget preview

![Weather Widget Example](https://github.com/TheNave8or/weather-check/blob/main/Example.png)

The widget displays current weather conditions, including temperature, feels-like temperature, and weather icons representing the current state of the weather. The design is compact and can be positioned anywhere on your screen.

## Setup Script

A setup script (`Setup.ahk` for AHK version and `Setup.lnk` for compiled version) is provided to simplify the configuration process for AHK script users.

### How to Use the Setup Script

1. **Run the Script:** Double-click `Setup.ahk` to open the configuration GUI.
2. **Enter Your Settings:**
    - **Latitude/Longitude:** Enter your geographical coordinates.
    - **Keep Weather Files:** Set to `1` to keep logs, `0` to delete them after use.
    - **Destination:** Choose a directory for saving weather logs. Leave empty to use the script's directory.
    - **Screen Position:** Set the X and Y position for the widget on your screen. Press F1 to toggle the mouse position tracker.
3. **Save Settings:** Click "Save Settings" to save your configuration to `settings.ini`.

## Default Configuration

The default configuration is not supported, and both versions (compiled and using AHK) will run the first setup. after that, only the AHK version has the setup file. (im working on including the setup file in the compiled version.)

```ini
[Settings]
; Latitude and Longitude
Latitude=YOUR_LATITUDE
Longitude=YOUR_LONGITUDE
; 1 to keep weather files, 0 to delete them after use
Keep=0
; Choose the destination for weather logs, keep empty to be the script's location
Destination=
; Location on the screen
XPosition=0
YPosition=0
```

## Usage

- **Launching the Widget:** After configuring the settings, run `WeatherCheck.ahk` or `WeatherCheck_win64.exe` for the compiled version.
- **Modifying Settings:** To change settings later, re-run `Setup.ahk` (for AHK script users) or manually edit `settings.ini` (for compiled version users).
- **Closing the Widget:** Press `Alt + F9` to close the widget.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for suggestions or bug reports.
