import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Для выбора изображения с устройства

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  String _imagePath = ''; // Путь к изображению (можно использовать для сохранения)
  String _nickname = '';
  String _about = '';
  String _location = '';
  bool _isDarkMode = false; // Для переключения темы
  bool _isMetric = true; // Для выбора системы исчисления

  // Функция для выбора фото с устройства
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50], // Светло-зеленый фон
      appBar: AppBar(
        title: Text('Профиль'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Аватар с карандашом для редактирования
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _imagePath.isEmpty
                      ? AssetImage('assets/default_avatar.png') // Стандартное изображение
                      : FileImage(File(_imagePath)) as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage, // Выбор фото
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.edit, size: 18, color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Блок "Никнейм и о себе"
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Никнейм и о себе',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      _nickname = text;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Никнейм',
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      _about = text;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'О себе',
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Блок "Локация"
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Локация',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: Text(_location.isEmpty ? 'Выберите локацию' : _location),
                  trailing: Icon(Icons.location_on),
                  onTap: () {
                    // Логика выбора локации
                    // В будущем можно подключить карту для выбора
                    setState(() {
                      _location = 'Новая локация';
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Блок "Системные настройки"
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Системные настройки',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: Text('Тема: ${_isDarkMode ? "Темная" : "Светлая"}'),
                  trailing: Switch(
                    value: _isDarkMode,
                    onChanged: (bool value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _isDarkMode = !_isDarkMode;
                    });
                  },
                ),
                ListTile(
                  title: Text('Система исчисления: ${_isMetric ? "Метрическая" : "Имперская"}'),
                  trailing: Switch(
                    value: _isMetric,
                    onChanged: (bool value) {
                      setState(() {
                        _isMetric = value;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _isMetric = !_isMetric;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}