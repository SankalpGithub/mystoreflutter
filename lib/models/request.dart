import 'dart:convert';
import 'package:http/http.dart' as http;


class request {
  // Define the URL you want to make a GET request to
  final String apiUrl = 'https://sankalp-gaikwad.onrender.com/send_app_data';

  // Function to make the GET request
  Future<List<dynamic>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> appData = json.decode(response.body);
        return appData;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}