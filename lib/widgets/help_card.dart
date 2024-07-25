import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class HelpCard extends StatelessWidget {
  final String title;
  final IconData icon;
  Function() onTap;

  HelpCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: Constants.primaryColor,
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
