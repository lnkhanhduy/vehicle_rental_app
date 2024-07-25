import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/chat/chat_details_screen.dart';
import 'package:vehicle_rental_app/screens/help/help_change_screen.dart';
import 'package:vehicle_rental_app/screens/help/help_contact_screen.dart';
import 'package:vehicle_rental_app/screens/help/help_filter_screen.dart';
import 'package:vehicle_rental_app/screens/help/help_order_screen.dart';
import 'package:vehicle_rental_app/screens/help/help_rating_screen.dart';
import 'package:vehicle_rental_app/screens/help/help_register_screen.dart';
import 'package:vehicle_rental_app/screens/help/help_return_screen.dart';
import 'package:vehicle_rental_app/screens/help/help_search_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/widgets/help_card.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.to(() => LayoutScreen(initialIndex: 4)),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Hỗ trợ khách hàng",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                    child: Column(
                      children: [
                        Text(
                          "Cần hỗ trợ nhanh vui lòng gọi 1900 1099 hoặc gửi tin nhắn để được hỗ trợ.",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (await canLaunchUrl(
                                        Uri.parse("tel:19001099"))) {
                                      await launchUrl(
                                        Uri.parse("tel:19001099"),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Constants.primaryColor,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    side: BorderSide(
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        EvaIcons.phoneCallOutline,
                                        color: Constants.primaryColor,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      const Text(
                                        "Gọi",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    UserModel user = UserModel(
                                      email: "admin@gmail.com",
                                      name: "Admin",
                                      phone: "19001099",
                                      password: '',
                                      isAdmin: true,
                                    );
                                    Get.to(() => ChatDetailsScreen(
                                          user: user,
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constants.primaryColor,
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        EvaIcons.messageSquare,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      const Text(
                                        "Gửi tin nhắn",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Hướng dẫn",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: HelpCard(
                              title: "Đăng ký cho thuê xe",
                              icon: EvaIcons.carOutline,
                              onTap: () {
                                Get.to(() => HelpRegisterScreen());
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: HelpCard(
                              title: "Đặt xe",
                              icon: Icons.car_rental_outlined,
                              onTap: () {
                                Get.to(() => HelpOrderScreen());
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: HelpCard(
                              title: "Tìm kiếm xe",
                              icon: EvaIcons.searchOutline,
                              onTap: () {
                                Get.to(() => HelpSearchScreen());
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: HelpCard(
                              title: "Lọc xe",
                              icon: Icons.filter_alt_outlined,
                              onTap: () {
                                Get.to(() => HelpFilterScreen());
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: HelpCard(
                              title: "Trả xe/hủy chuyến",
                              icon: Icons.keyboard_return,
                              onTap: () {
                                Get.to(() => HelpReturnScreen());
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: HelpCard(
                              title: "Đánh giá xe",
                              icon: Icons.edit_outlined,
                              onTap: () {
                                Get.to(() => HelpRatingScreen());
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: HelpCard(
                              title: "Đổi thông tin",
                              icon: Icons.change_circle_outlined,
                              onTap: () {
                                Get.to(() => HelpChangeScreen());
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: HelpCard(
                              title: "Liên hệ chủ xe",
                              icon: Icons.contact_phone_outlined,
                              onTap: () {
                                Get.to(() => HelpContactScreen());
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
