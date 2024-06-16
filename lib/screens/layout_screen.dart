import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/home_screen.dart';
import 'package:vehicle_rental_app/screens/profile/profile_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    Get.closeCurrentSnackbar();
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: const [
            HomeScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Trang chủ",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
              BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
            ],
            selectedItemColor: Constants.primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontSize: 13),
            unselectedLabelStyle: const TextStyle(fontSize: 13),
          ),
        ));
  }
}
