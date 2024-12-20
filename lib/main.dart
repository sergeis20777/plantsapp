import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/bottom_nav_provider.dart';
import './providers/reminder_provider.dart';
import 'widgets/bottom_nav_bar.dart';
import 'screens/home_screen.dart';
import 'screens/plants_screen.dart';
import 'screens/search_screen.dart';
import 'screens/health_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReminderProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BottomNavProvider(),
      child: MaterialApp(
        title: 'Flutter Navigation Demo',
        theme: ThemeData(primarySwatch: Colors.green),
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  final List<Widget> pages = [
    HomeScreen(),
    PlantsScreen(),
    SearchScreen(),
    HealthScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: pages[bottomNavProvider.currentIndex],
      bottomNavigationBar: BottomNavBar(),
    );
  }
}