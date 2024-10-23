<h1>Zeoweather Mobile Applicaton</h1>

This Flutter application provides real-time weather information for multiple cities. The app fetches weather data from a openweathermap API and displays it, including the current temperature, weather condition, and hourly and historical weather data. Additionally, users are alerted via email when the temperature exceeds a predefined threshold.

Here is the first Glimpse of the Mobile App:

![Screenshot_20241023_173141](https://github.com/user-attachments/assets/972acbe8-70e7-46f9-8ee0-3dcba6e17a68)


<h3>Features</h3>
 -  City Selection Dropdown: Choose between cities such as Hyderabad, Mumbai, Chennai, and Kolkata using a dropdown menu. The weather data automatically updates for the selected city.
 

 - Real-time Weather Data: The app displays real-time temperature and weather conditions for the selected city.

 - Hourly Forecast: Scrollable hourly weather data is displayed, including temperatures for each hour of the day.

 - Historical Weather Data: The app shows past weather conditions, such as the average, minimum, and maximum temperatures for each day.

 - Weather Alerts: When the temperature exceeds a user-defined threshold, the app triggers an email alert to notify the user.

 - Last Updated Time: The app shows the last time the weather data was updated.

 - Customizable Settings: Users can configure their temperature threshold and other preferences in the settings page.


<h3>Prerequisites</h3>

 - Flutter SDK: Ensure you have Flutter installed. You can install Flutter by following the instructions here: Flutter Installation
<br>
 - Weather API Key: This app fetches data from a weather API. You will need an API key to fetch weather data. You can get one from OpenWeatherMap.
 - **Note**
Since the hourly data for a city require paid plan in the openweathermap API, hence I have used the weatherapi.com API to integrate the hourly data feature.


<h3>Installation<h3>
1. Clone the repository
```bash
git clone https://github.com/Hemanth5603/Zeoweather.git
```

2.Install the dependencies
```bash
flutter pub get
```

3. Update the API key: <br>
Open the weather_service.dart file and replace the placeholder API key with your own API from [openweathermap.com](https://openweathermap.org/) and https://www.weatherapi.com/:

4. Run the application:

```bash
flutter run
```

