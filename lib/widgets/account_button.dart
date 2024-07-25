import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final String title;
  final bool isVerified;

  const AccountButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
    this.isVerified = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black.withOpacity(0.65),
                  size: 24,
                ),
                SizedBox(width: 14),
                Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            if (isVerified == true)
              Icon(Icons.chevron_right, size: 24, color: Colors.black),
            if (isVerified == false)
              Icon(Icons.error_outline_outlined, size: 24, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
