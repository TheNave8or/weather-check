# Weather Widget for AutoHotkey

This project is a customizable weather widget for Windows using AutoHotkey (AHK). It fetches weather data from the [Open-Meteo API](https://open-meteo.com/) and displays it in a compact, always-on-top window on your desktop.

## Features

- **Weather Data:** Current temperature, feels-like temperature, weather conditions, and more.
- **Customization:** Change screen position, keep or delete weather logs, and set your geographical coordinates.
- **Visuals:** Displays weather icons based on current conditions.

## Installation

1. **Download and Extract Files:**
   - Download the repository and extract the files to a folder on your computer.

2. **Configure Settings:**
   - Run the `Setup.ahk` script to set up your initial settings, such as latitude, longitude, screen position, etc.
   - The settings will be saved in the `settings.ini` file.

3. **Run the Widget:**
   - Launch the main script `WeatherCheck.ahk` to start the weather widget.

## Setup Script

A setup script (`Setup.ahk`) is provided to simplify the configuration process. 

### How to Use the Setup Script

1. **Run the Script:** Double-click `Setup.ahk` to open the configuration GUI.
2. **Enter Your Settings:** 
   - **Latitude/Longitude:** Your geographical coordinates.
   - **Keep Weather Files:** Set to `1` to keep logs, `0` to delete them after use.
   - **Destination:** Directory for saving weather logs. Leave empty to use the script's directory.
   - **Screen Position:** Set the X and Y position for the widget on your screen. Press F1 to toggle the mouse position tracker.
3. **Save Settings:** Click "Save Settings" to save your configuration to `settings.ini`.

### Default Configuration

The default configuration is stored in `settings.ini`:

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

- **Launching the Widget:** After configuring the settings, run `WeatherCheck.ahk`.
- **Modifying Settings:** To change settings later, re-run `Setup.ahk`.
- **Closing the Widget:** Press Alt + F9 to close the widget.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for suggestions or bug reports.
