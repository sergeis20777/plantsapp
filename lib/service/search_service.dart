import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchService {
  static Future<List<String>> fetchFromServer(String query, Map<String, dynamic> filters) async {
    final uri = Uri.http(
      'your-microservice-url',
      '/api/plants/search',
      {
        'query': query,
        'temperature': filters['temperature']?.toString(),
        'humidity': filters['humidity']?.toString(),
        'light': filters['light'],
      },
    );
    return List.generate(5, (index) => 'Plant ${index + 1}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception('Ошибка при получении данных');
    }
  }
}