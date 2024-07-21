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
        Get.to(() => UserPaperScreen(
            user: user, view: true, title: "Xét duyệt giấy tờ"));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              SizedBox(
                width: 80,
                height: 50,
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
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    (user.isVerified == true &&
                            (user.message == null || user.message!.isEmpty))
                        ? const Text(
                            'Đã duyệt',
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          )
                        : (user.isVerified != true &&
                                user.message != null &&
                                user.message!.isNotEmpty)
                            ? const Text(
                                'Từ chối',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.red),
                              )
                            : const Text(
                                'Chưa duyệt',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.red),
                              ),
                    user.isVerified != true &&
                            user.message != null &&
                            user.message!.isNotEmpty
                        ? Text(
                            'Lý do: ${user.message!}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.red),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
