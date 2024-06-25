import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/user/user_paper_screen.dart';

class UserCardApprove extends StatelessWidget {
  final bool view;
  final UserModel user;

  const UserCardApprove({super.key, required this.user, this.view = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => UserPaperScreen(user: user, view: true));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        image: Image.network(
                          user.imageAvatar!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "lib/assets/images/no_image.png",
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
