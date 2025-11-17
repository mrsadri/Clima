# Clima ☀️🌧️

A beautiful iOS weather app with a unique twist: **Masih World Time** - a revolutionary time system that harmonizes with nature's rhythm.

![iOS](https://img.shields.io/badge/iOS-9.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## 🌟 Features

### Weather Information
- **Real-time Weather Data**: Get current weather conditions for any location
- **Location-Based**: Automatically detects your current location
- **Manual City Selection**: Search and select any city worldwide
- **Detailed Weather Conditions**: Temperature, weather icons, and conditions
- **Beautiful UI**: Stunning weather-specific backgrounds and icons

### 🕐 Masih World Time - The Unique Innovation

This app introduces a revolutionary concept: **time that adapts to daylight hours**. 

**The Concept:**
- Daylight hours (sunrise to sunset) are always mapped to **6:00 AM - 6:00 PM** (12 hours)
- Nighttime hours (sunset to sunrise) are always mapped to **6:00 PM - 6:00 AM** (12 hours)
- Time flows faster or slower based on the actual length of daylight in your location
- Features a beautiful analog clock with hour, minute, and second hands

**Why?**
- Experience time as nature intended
- 6 AM always means "just after sunrise"
- 6 PM always means "just after sunset"  
- Noon (12 PM) is always the middle of the daylight period
- A unique perspective on how we perceive time across different seasons and locations

## 📸 Screenshots

The app displays:
- Current temperature
- City name
- Weather condition icons (sunny, cloudy, rainy, snowy, foggy, thunderstorm)
- Animated analog clock showing Masih World Time
- Beautiful background that changes with weather

## 🛠️ Technologies Used

- **Swift 4.0** - Modern iOS development
- **UIKit** - User interface framework
- **CoreLocation** - GPS and location services
- **Alamofire** - Elegant HTTP networking
- **SwiftyJSON** - JSON parsing made simple
- **SVProgressHUD** - Clean loading indicators
- **OpenWeatherMap API** - Weather data provider

## 📋 Requirements

- iOS 9.0+
- Xcode 9.0+
- CocoaPods
- OpenWeatherMap API Key

## 🚀 Installation

1. Clone the repository:
```bash
git clone https://github.com/mrsadri/Clima.git
cd Clima
```

2. Install dependencies:
```bash
pod install
```

3. Open the workspace:
```bash
open Clima.xcworkspace
```

4. Get your free API key from [OpenWeatherMap](https://openweathermap.org/api)

5. Add your API key in `WeatherViewController.swift`:
```swift
let APP_ID = "YOUR_API_KEY_HERE"
```

6. Build and run the project in Xcode

## 🎯 How It Works

### Weather Fetching
The app uses the OpenWeatherMap API to fetch:
- Current temperature
- Weather conditions
- Sunrise and sunset times
- City name

### Masih World Time Algorithm
```swift
// Daylight hours are compressed/stretched to always equal 12 hours (6 AM - 6 PM)
let dayLengthInSeconds = sunsetTime - sunriseTime
let extendRate = dayLengthInSeconds / 43200 // 43200 = 12 hours in seconds

// Current time is then mapped to this 12-hour daylight window
// Nighttime follows the same logic but in reverse
```

## 🎨 Weather Conditions

The app displays different icons for:
- ☀️ Sunny
- ☁️ Cloudy
- 🌧️ Light Rain
- 🌧️ Heavy Rain
- ❄️ Snow
- 🌫️ Fog
- ⛈️ Thunderstorm
- ❓ Unknown conditions

## 📱 Usage

1. **Launch the app** - It will request location permission
2. **View current weather** - See your local weather and Masih World Time
3. **Change city** - Tap the location icon to search for any city
4. **Watch the clock** - Observe how time flows differently based on daylight

## 🧠 The Philosophy

> "What if we measured time not by atomic clocks, but by the sun itself? In summer, when days are long, an hour would last longer. In winter, when nights dominate, time would slow down. Masih World Time is an exploration of how we might experience time if it were tied to nature's rhythm rather than arbitrary mechanical divisions."

## 🤝 Contributing

This is a learning project from 2018, but contributions are welcome for:
- UI improvements
- Additional weather data
- Animation enhancements
- Bug fixes

## 📄 License

This project is open source and available under the MIT License.

## 👤 Author

**Masih Sadri**
- GitHub: [@mrsadri](https://github.com/mrsadri)

## 🙏 Acknowledgments

- OpenWeatherMap for weather data API
- Original clock design concept
- iOS development community

---

*Created in 2018 as an exploration of time, weather, and innovative iOS development*

