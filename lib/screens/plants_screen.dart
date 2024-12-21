import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';

class PlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plants Screen'),
        actions: [
          GestureDetector(
            onTap: () {
              // Переход на экран профиля
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage('URL_ФОТО_ПОЛЬЗОВАТЕЛЯ'), // Или Image.asset('assets/images/user_photo.jpg')
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Text('Контент главного экрана'),
      ),
    );
  }
}