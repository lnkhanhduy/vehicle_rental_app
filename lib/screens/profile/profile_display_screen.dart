import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vehicle_rental_app/controllers/car_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/chat/chat_details_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/widgets/car_card.dart';

class ProfileDisplayScreen extends StatefulWidget {
  final UserModel? userModel;

  const ProfileDisplayScreen({super.key, this.userModel});

  @override
  State<ProfileDisplayScreen> createState() => _ProfileDisplayScreenState();
}

class _ProfileDisplayScreenState extends State<ProfileDisplayScreen> {
  final carController = Get.put(CarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
        title: Text(
          widget.userModel?.name ?? "Tài khoản",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.home_outlined,
              size: 24,
            ),
            onPressed: () {
              Get.to(() => const LayoutScreen(initialIndex: 0));
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: FutureBuilder<List<CarModel>?>(
                future: carController
                    .getCarProfileScreen(widget.userModel?.email ?? ""),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingScreen();
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    List<CarModel>? cars = snapshot.data;
                    return Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            child: widget.userModel?.imageAvatar != null
                                ? Image.network(
                                    widget.userModel!.imageAvatar!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "lib/assets/images/no_avatar.png",
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    "lib/assets/images/no_avatar.png",
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.userModel?.name ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.userModel!.phone.isNotEmpty &&
                                widget.userModel!.isPublic == true)
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final Uri url = Uri(
                                        scheme: 'tel',
                                        path: widget.userModel!.phone,
                                      );
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Image.asset(
                                          "lib/assets/icons/phone-call.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "Gọi điện",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            if (widget.userModel!.phone.isNotEmpty &&
                                widget.userModel!.isPublic)
                              const SizedBox(width: 32),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => ChatDetailsScreen(
                                        user: widget.userModel!));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "lib/assets/icons/chat.png",
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Nhắn tin",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 13,
                                height: 13,
                                child: Image.asset(
                                  "lib/assets/icons/star.png",
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(widget.userModel != null
                                  ? widget.userModel!.star != 0 &&
                                          widget.userModel!.totalRental != 0
                                      ? (widget.userModel!.star /
                                              widget.userModel!.totalRental)
                                          .toStringAsFixed(1)
                                      : "0"
                                  : "0"),
                              SizedBox(
                                width: 17,
                                height: 17,
                                child: Image.asset(
                                  "lib/assets/icons/dot_full.png",
                                ),
                              ),
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Image.asset(
                                  "lib/assets/icons/road_trip.png",
                                  color: Constants.primaryColor,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                  "${widget.userModel?.totalRental ?? 0} chuyến"),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Xe đã cho thuê (${cars!.length})",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        cars.isNotEmpty
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: cars.map((car) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      child: CarCard(car: car),
                                    );
                                  }).toList(),
                                ),
                              )
                            : const Text(
                                "Tất cả các xe đang được cho thuê. Vui lòng quay lại sau."),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
