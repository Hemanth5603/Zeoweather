import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailService extends GetxController{



  Future<void> sendEmailAlert(double temperature,String weather, String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email")!;
    print("email :$email");
    String apiUrl = 'https://email-notification-server-r03u.onrender.com/send_email';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'to': email,
        'weather': weather,
        'location': location, 
        'temperature': temperature.toStringAsFixed(0),
        'time':DateFormat('HH:mm').format(DateTime.now()),
        'date':DateFormat('yyyy-MM-dd').format(DateTime.now()),
      },
    );

    if (response.statusCode == 200) {
      print('Alert email sent successfully');
    } else {
      print(response.statusCode);
      print('Failed to send alert email');
    }
  }
}