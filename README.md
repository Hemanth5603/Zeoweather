<h1>Zeoweather Mobile Application</h1>

<p>This Flutter application provides real-time weather information for multiple cities. The app fetches weather data from a openweathermap API and displays it, including the current temperature, weather condition, and hourly and historical weather data. Additionally, users are alerted via email when the temperature exceeds a predefined threshold.</p>
<be>
<p>The application is build using the MVC(Model View Controller Architecture)</p>

<p><strong>APK Download Link:</strong> <a href="https://drive.google.com/file/d/1Qy4rMqP6jHfEbnNn6hF0DH2LtFaejOBl/view?usp=sharing" target="_blank">Download Here</a></p>

<h3>Here is the first Glimpse of the Mobile App and the email notification:</h3>

<div style="display: flex; gap: 10px;">
    <img src="https://github.com/user-attachments/assets/e008146b-fc74-4e4e-ba6a-e8b7970fa5b8" alt="Screenshot of the App" style="width: 45%;">
    <img src="https://github.com/user-attachments/assets/773e92b9-c275-4801-a26c-7fd73933ac9c" alt="Screenshot of Email Notification" style="width: 45%;">
</div>


<h3>Application Working Video</h3> <br>
https://github.com/user-attachments/assets/c94636ec-0b24-40a4-8647-3934679eb4ab





<h2>Note</h2>
 - The Weather data is fetched every 5 minutes so, whenever the configured threshold value of temperature is reached an email notification is send to the email address only once.
 <br>
 - Since the app does not run in the background, therefore in order to receive email notification the app needs to kept open.
    

<h3>Features</h3>
 -  City Selection Dropdown: Choose between cities such as Hyderabad, Mumbai, Chennai, and Kolkata using a dropdown menu. The weather data automatically updates for the selected city.
 

 - Real-time Weather Data: The app displays real-time temperature and weather conditions for the selected city.

 - Hourly Forecast: Scrollable hourly weather data is displayed, including temperatures for each hour of the day.

 - Historical Weather Data: The app shows past weather conditions, such as the average, minimum, and maximum temperatures for each day.

 - Weather Alerts: When the temperature exceeds a user-defined threshold, the app triggers an email alert to notify the user.

 - Last Updated Time: The app shows the last time the weather data was updated.

 - Customizable Settings: Users can configure their temperature threshold and other preferences in the settings page.


<h3>System Architecture </h3>
<img src="https://github.com/user-attachments/assets/e55fd07c-f2e4-4efc-a68d-c8f09720c8a0" alt="Screenshot of the App" style="width: 45%;">



<h3>Prerequisites</h3>

 - Flutter SDK: Ensure you have Flutter installed. You can install Flutter by following the instructions here: Flutter Installation
<br>
 -  Weather API Key: This app fetches data from a weather API. You will need an API key to fetch weather data. You can get one from OpenWeatherMap.
<br>
 - **Note** <br>
 
Since the hourly data for a city require paid plan in the openweathermap API, hence I have used the weatherapi.com API to integrate the hourly data feature.


<h3>Installation</h3>

<ol>
    <li>
        <strong>Clone the Repository:</strong>
        <pre><code>git clone https://github.com/Hemanth5603/Zeoweather.git</code></pre>
    </li>
    <li>
        <strong>Install the Dependencies:</strong>
        <pre><code>flutter pub get</code></pre>
    </li>
    <li>
        <strong>Update the API Key:</strong>
        <p>Open the <code>weather_service.dart</code> file and replace the placeholder API key with your own API key from the following sources:</p>
        <ul>
            <li><a href="https://openweathermap.com/" target="_blank">OpenWeatherMap</a></li>
            <li><a href="https://www.weatherapi.com/" target="_blank">WeatherAPI</a></li>
        </ul>
    </li>
    <li>
        <strong>Run the Application:</strong>
        <pre><code>flutter run</code></pre>
    </li>
</ol>

<h3>Some more screenshots of the application</h3>


<div style="display: flex; gap: 10px;">
    <img src="https://github.com/user-attachments/assets/8a030013-3860-48ed-8267-2ea2fb3c9139" alt="App Screenshot 1" style="width: 45%;">
    <img src="https://github.com/user-attachments/assets/9742956d-7920-447d-b6ee-daa0a5f2ab3c" alt="App Screenshot 2" style="width: 45%;">
</div>


