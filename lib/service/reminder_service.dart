import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/reminder.dart';

class ReminderService {
  static const String baseUrl = "http://your-microservice-url/api/reminders";

  Future<List<Reminder>> fetchReminders() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Reminder.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load reminders");
    }
  }
}