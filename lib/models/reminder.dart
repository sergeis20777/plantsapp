class Reminder {
  final int id;
  final String title;
  final String description;
  final DateTime time;

  Reminder({required this.id, required this.title, required this.description, required this.time});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      time: DateTime.parse(json['time']),
    );
  }
}