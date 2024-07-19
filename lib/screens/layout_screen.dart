import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/chat/chat_screen.dart';
import 'package:vehicle_rental_app/screens/home_screen.dart';
import 'package:vehicle_rental_app/screens/profile/account_screen.dart';
import 'package:vehicle_rental_app/screens/register_car/info_rental_screen.dart';
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
  PageController _pageController = PageController();

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
          InfoRentalScreen(),
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
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Yêu thích"),
            BottomNavigationBarItem(
                icon: Icon(Icons.car_rental), label: "Cho thuê"),
            BottomNavigationBarItem(
                icon: Icon(EvaIcons.messageSquare), label: "Tin nhắn"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2), label: "Tài khoản"),
          ],
          selectedItemColor: Constants.primaryColor,
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontSize: 13),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
