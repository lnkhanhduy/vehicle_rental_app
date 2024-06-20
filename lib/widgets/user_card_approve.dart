import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/approve_user_paper_screen.dart';

class UserCardApprove extends StatelessWidget {
  final UserModel user;

  const UserCardApprove({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(() => ApproveUserPaperScreen(
                user: user,
              ));
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: user.imageAvatar != null
                      ? Image(
                          image: NetworkImage(user.imageAvatar!),
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
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên: ${user.name}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Email: ${user.email}',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    user.isVerified == true
                        ? const Text(
                            'Đã duyệt',
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          )
                        : const Text(
                            'Chưa duyệt',
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          ),
                  ],
                )
              ],
            ),
          ]),
        ));
  }
}
