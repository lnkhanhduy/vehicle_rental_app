import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/home_screen.dart';
import 'package:vehicle_rental_app/screens/user/account_screen.dart';
import 'package:vehicle_rental_app/screens/user/chat_screen.dart';
import 'package:vehicle_rental_app/screens/user/favorite_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class LayoutScreen extends StatefulWidget {
  final int initialIndex;

  const LayoutScreen({super.key, this.initialIndex = 0});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _currentIndex = 0;
  late PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

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
            FavoriteScreen(),
            ChatScreen(),
            AccountScreen(),
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
                  icon: Icon(Icons.favorite), label: "Yêu thích"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message_outlined), label: "Tin nhắn"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Tài khoản"),
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
