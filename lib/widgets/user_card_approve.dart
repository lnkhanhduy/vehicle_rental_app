import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/profile/user_paper_screen.dart';

class UserCardApprove extends StatelessWidget {
  final bool view;
  final UserModel user;

  const UserCardApprove({super.key, required this.user, this.view = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() =>
            UserPaperScreen(user: user, view: true, title: "Duyệt giấy tờ"));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: (user.isVerified == true &&
                    (user.message == null && user.message!.isEmpty))
                ? Colors.green
                : (user.isVerified != true &&
                        (user.message != null && user.message!.isNotEmpty))
                    ? Colors.redAccent
                    : Colors.grey,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: user.imageAvatar != null
                              ? Image(
                                  image: Image.network(
                                    user.imageAvatar!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "lib/assets/images/no_avatar.png",
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ).image,
                                  width: 60,
                                  height: 40,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "lib/assets/images/no_avatar.png",
                                  width: 60,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.email,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 4),
                      (user.isVerified == true &&
                              (user.message == null || user.message!.isEmpty))
                          ? Icon(Icons.check, color: Colors.green)
                          : (user.isVerified != true &&
                                  user.message != null &&
                                  user.message!.isNotEmpty)
                              ? Icon(Icons.close, color: Colors.red)
                              : Icon(Icons.warning_amber, color: Colors.grey)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
