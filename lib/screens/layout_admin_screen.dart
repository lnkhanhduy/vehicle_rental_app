import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/admin/approve_car_screen.dart';
import 'package:vehicle_rental_app/screens/admin/approve_user_paper_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class LayoutAdminScreen extends StatefulWidget {
  final int initialIndex;

  const LayoutAdminScreen({super.key, this.initialIndex = 0});

  @override
  State<LayoutAdminScreen> createState() => _LayoutAdminScreenState();
}

class _LayoutAdminScreenState extends State<LayoutAdminScreen> {
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
          ApproveCarScreen(),
          ApproveUserPaperScreen(),
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
            BottomNavigationBarItem(
                icon: Icon(Icons.car_crash_outlined), label: "Duyệt xe"),
            BottomNavigationBarItem(
                icon: Icon(Icons.manage_accounts_outlined),
                label: "Duyệt giấy tờ"),
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
