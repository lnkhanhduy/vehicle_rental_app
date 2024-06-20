import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/car/confirm_rental_screen.dart';
import 'package:vehicle_rental_app/screens/profile/profile_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/widgets/rating_rental.dart';

import '../home_screen.dart';

class CarDetailsScreen extends StatefulWidget {
  final Car car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(days: 1));

  final PageController imageController = PageController();
  int currentImage = 1;

  @override
  void initState() {
    super.initState();
    imageController.addListener(() {
      setState(() {
        currentImage = imageController.page!.round() + 1;
      });
    });
  }

  @override
  void dispose() {
    imageController.dispose();
    super.dispose();
  }

  bool isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
          SliverAppBar(
            expandedHeight: 240,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black.withAlpha(0),
                          Colors.black12,
                          Colors.black45
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: constraints.maxHeight - 240.0,
                    child: PageView.builder(
                      controller: imageController,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          "lib/assets/images/no_car_image.png",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '$currentImage/10',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ],
            pinned: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'CAMRY',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
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
                      const Text("5.0"),
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
                      const SizedBox(
                        width: 6,
                      ),
                      const Text("2 chuyến"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Thời gian thuê xe",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Nhận xe",
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.all(0),
                                            ),
                                            onPressed: () async {
                                              final result =
                                                  await showBoardDateTimePicker(
                                                      context: context,
                                                      pickerType:
                                                          DateTimePickerType
                                                              .datetime,
                                                      options:
                                                          const BoardDateTimeOptions(
                                                              languages:
                                                                  BoardPickerLanguages(
                                                        locale: 'vi',
                                                        today: 'Hôm nay',
                                                        tomorrow: 'Ngày mai',
                                                      )));
                                              if (result != null) {
                                                setState(() {
                                                  fromDate = result;
                                                });
                                              }
                                            },
                                            child: Text(
                                              BoardDateFormat(
                                                      'HH:mm dd/MM/yyyy')
                                                  .format(fromDate),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Trả xe",
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.all(0),
                                            ),
                                            onPressed: () async {
                                              final result =
                                                  await showBoardDateTimePicker(
                                                      context: context,
                                                      pickerType:
                                                          DateTimePickerType
                                                              .datetime,
                                                      options:
                                                          const BoardDateTimeOptions(
                                                              languages:
                                                                  BoardPickerLanguages(
                                                        locale: 'vi',
                                                        today: 'Hôm nay',
                                                        tomorrow: 'Ngày mai',
                                                      )));
                                              if (result != null) {
                                                setState(() {
                                                  fromDate = result;
                                                });
                                              }
                                            },
                                            child: Text(
                                              BoardDateFormat(
                                                      'HH:mm dd/MM/yyyy')
                                                  .format(fromDate),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Địa điểm giao nhận xe",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                color: Colors.white,
                              ),
                              child: Stack(children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: null,
                                      groupValue: null,
                                      onChanged: (value) {},
                                    ),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tôi tự đến lấy xe",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Quận 6 TPHCM",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Text(
                                    "Miễn phí",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Constants.primaryColor),
                                  ),
                                )
                              ]),
                            ),
                          ])),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Đặc điểm",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset(
                              "lib/assets/icons/gear_shift.png",
                              color: Constants.primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Truyền động",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Text("Số tự động",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset(
                              "lib/assets/icons/car_seat.png",
                              color: Constants.primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Số ghế",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Text("7 ghế",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset(
                              "lib/assets/icons/fuel.png",
                              color: Constants.primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Nhiên liệu",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Text("Xăng",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Mô tả",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This is a long description text that should be expandable and collapsible. '
                        'Initially, it will show only a few lines, and when the "See More" text is tapped, '
                        'it will expand to show the full text. Similarly, when the "See Less" text is tapped, '
                        'it will collapse back to the initial few lines.',
                        maxLines: isExpanded ? null : 4,
                        overflow: isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: _toggleExpanded,
                        child: Text(
                          isExpanded ? 'Thu gọn' : 'Xem thêm',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Constants.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Các tiện nghi trên xe",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      "lib/assets/icons/map.png",
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("Bản đồ")
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      "lib/assets/icons/cctv.png",
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("Camera hành trình")
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Transform.rotate(
                                      angle: 270 * 3.14 / 180,
                                      child: Image.asset(
                                        "lib/assets/icons/sensor.png",
                                        color: Constants.primaryColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("Cảm biến va chạm")
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      "lib/assets/icons/usb.png",
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("Khe cắm USB")
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      "lib/assets/icons/tablet.png",
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("Màn hình")
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      "lib/assets/icons/air_bag.png",
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("Túi khí an toàn")
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      "lib/assets/icons/bluetooth.png",
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("Bluetooth")
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      "lib/assets/icons/camera.png",
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("Camera lùi")
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      "lib/assets/icons/tire.png",
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("Lốp dự phòng")
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      "lib/assets/icons/etc.png",
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("ETC")
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Vị trí xe",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Quận 6 TPHCM"),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Chủ xe",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const ProfileScreen());
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.asset(
                                "lib/assets/images/no_avatar.png",
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Lê Nguyễn Khánh Duy",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Row(
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
                                    const Text("5.0"),
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
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    const Text("2 chuyến"),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Đánh giá từ khách thuê",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Column(
                    children: [
                      RatingRental(),
                      SizedBox(
                        height: 15,
                      ),
                      RatingRental()
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          color: Constants.primaryColor.withOpacity(0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("633K",
                      style: TextStyle(
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  const Text(" / ngày")
                ],
              ),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const ConfirmRentalScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: const Text(
                    "Thuê xe",
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
