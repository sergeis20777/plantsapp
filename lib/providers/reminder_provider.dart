import 'package:flutter/material.dart';
import '../models/reminder.dart';
import '../service/reminder_service.dart';

class ReminderProvider with ChangeNotifier {
  final ReminderService _service = ReminderService();
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  Future<void> loadReminders() async {
    try {
      _reminders = await _service.fetchReminders();
      notifyListeners();
    } catch (e) {
      print("Error loading reminders: $e");
    }
  }
}