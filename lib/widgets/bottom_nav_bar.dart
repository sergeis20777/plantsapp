import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bottom_nav_provider.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return BottomNavigationBar(
      currentIndex: bottomNavProvider.currentIndex,
      onTap: (index) {
        bottomNavProvider.updateIndex(index);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.green.shade100,
      selectedItemColor: Colors.green.shade900,
      unselectedItemColor: Colors.green.shade700,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        _buildNavItem(Icons.home, 0, bottomNavProvider.currentIndex),
        _buildNavItem(Icons.grass, 1, bottomNavProvider.currentIndex),
        _buildNavItem(Icons.search, 2, bottomNavProvider.currentIndex),
        _buildNavItem(Icons.medical_services, 3, bottomNavProvider.currentIndex),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, int index, int currentIndex) {
    bool isSelected = index == currentIndex;

    return BottomNavigationBarItem(
      icon: Container(
        decoration: isSelected
            ? BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.5), // Полупрозрачный белый цвет
        )
            : null,
        padding: const EdgeInsets.all(8), // Отступы внутри круга
        child: Icon(icon),
      ),
      label: '',
    );
  }
}