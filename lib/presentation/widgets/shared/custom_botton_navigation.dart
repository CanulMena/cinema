import 'package:flutter/material.dart';

class CustomBottonNavigation extends StatelessWidget {
  const CustomBottonNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(elevation: 0, items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'home'),
      BottomNavigationBarItem(
          icon: Icon(Icons.label_important_outline), label: 'categorias'),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined), label: 'favoritos'),
    ]);
  }
}
