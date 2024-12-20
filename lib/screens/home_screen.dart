import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reminder_provider.dart';
import '../models/reminder.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reminderProvider = Provider.of<ReminderProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Напоминания")),
      body: FutureBuilder(
        future: reminderProvider.loadReminders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Ошибка загрузки напоминаний"));
          } else {
            final reminders = reminderProvider.reminders;

            return ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final Reminder reminder = reminders[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.notification_important, color: Colors.green),
                    title: Text(reminder.title),
                    subtitle: Text(reminder.description),
                    trailing: Text(
                      "${reminder.time.hour}:${reminder.time.minute.toString().padLeft(2, '0')}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}