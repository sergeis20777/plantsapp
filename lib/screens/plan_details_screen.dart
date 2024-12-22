import 'package:flutter/material.dart';

class PlantDetailScreen extends StatelessWidget {

  final String plantName;

  PlantDetailScreen({required this.plantName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plantName),
      ),
      body: Center(
        child: Text('Детальная информация о растении $plantName'),
      ),
    );
  }
}