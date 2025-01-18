import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

class ApiProvider {
  final String baseUrl = 'https://api.jsonserve.com/';

  Future<Map<String, dynamic>> getQuizData() async {
    try {
      developer.log('Fetching quiz data from: ${baseUrl}Uw5CrX');
      final response = await http.get(Uri.parse('${baseUrl}Uw5CrX'));

      developer.log('Response status code: ${response.statusCode}');
      developer.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to load quiz data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('Error in getQuizData: $e');
      throw Exception('Error fetching quiz data: $e');
    }
  }
}
