import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';
import 'package:vehicle_rental_app/screens/car/confirm_rental_screen.dart';
import 'package:vehicle_rental_app/screens/profile/profile_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';
import 'package:vehicle_rental_app/widgets/rating_rental.dart';

class CarDetailsScreen extends StatefulWidget {
  final CarModel car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(days: 1));

  final PageController imageController = PageController();
  int currentImage = 1;
  List<String> imageNames = [];
  late UserModel userModel;

  List<Map<String, dynamic>> amenities = [];

  @override
  void initState() {
    super.initState();
    imageController.addListener(() {
      setState(() {
        currentImage = imageController.page!.round() + 1;
      });
    });

    imageNames = [
      widget.car.imageCarMain!,
      widget.car.imageCarInside!,
      widget.car.imageCarFront!,
      widget.car.imageCarBack!,
      widget.car.imageCarLeft!,
      widget.car.imageCarRight!,
    ];

    amenities = [
      {
        'name': 'Bản đồ',
        'iconPath': 'lib/assets/icons/map.png',
        'isAvailable': widget.car.map
      },
      {
        'name': 'Camera hành trình',
        'iconPath': 'lib/assets/icons/cctv.png',
        'isAvailable': widget.car.cctv
      },
      {
        'name': 'Cảm biến va chạm',
        'iconPath': 'lib/assets/icons/sensor.png',
        'isAvailable': widget.car.sensor
      },
      {
        'name': 'Khe cắm USB',
        'iconPath': 'lib/assets/icons/usb.png',
        'isAvailable': widget.car.usb
      },
      {
        'name': 'Màn hình',
        'iconPath': 'lib/assets/icons/tablet.png',
        'isAvailable': widget.car.tablet
      },
      {
        'name': 'Túi khí an toàn',
        'iconPath': 'lib/assets/icons/air_bag.png',
        'isAvailable': widget.car.airBag
      },
      {
        'name': 'Bluetooth',
        'iconPath': 'lib/assets/icons/bluetooth.png',
        'isAvailable': widget.car.bluetooth
      },
      {
        'name': 'Camera lùi',
        'iconPath': 'lib/assets/icons/camera.png',
        'isAvailable': widget.car.cameraBack
      },
      {
        'name': 'Lốp dự phòng',
        'iconPath': 'lib/assets/icons/tire.png',
        'isAvailable': widget.car.tire
      },
      {
        'name': 'ETC',
        'iconPath': 'lib/assets/icons/etc.png',
        'isAvailable': widget.car.etc
      },
    ];

    amenities = amenities.where((amenity) => amenity['isAvailable']).toList();
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
                      itemCount: imageNames.length,
                      itemBuilder: (context, index) {
                        if (imageNames[index].isNotEmpty) {
                          return Image.network(
                            imageNames[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "lib/assets/images/no_image.png",
                                fit: BoxFit.cover,
                              );
                            },
                          );
                        } else {
                          return Image.asset("lib/assets/images/no_image.png",
                              fit: BoxFit.cover);
                        }
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
                          '$currentImage/${imageNames.length}',
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
                onPressed: () {
                  UserRepository.instance.addFavorite(widget.car.id!);
                },
              ),
            ],
            pinned: true,
          ),
          SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                constraints: const BoxConstraints.expand(),
                color: Colors.white,
                child: FutureBuilder(
                    future: Future.wait([
                      UserRepository.instance.getUserDetails(widget.car.email!),
                    ]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        UserModel userDetail = snapshot.data![0] as UserModel;
                        userModel = userDetail;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.car.carInfoModel,
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
                                Text(widget.car.star != null &&
                                        widget.car.star!.isNotEmpty
                                    ? widget.car.star!
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
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                    '${widget.car.totalRental != null ? widget.car.totalRental! : "0"} chuyến'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Thời gian thuê xe",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 15, 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                      style:
                                                          TextButton.styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                      ),
                                                      onPressed: () async {
                                                        final result =
                                                            await showBoardDateTimePicker(
                                                                context:
                                                                    context,
                                                                pickerType:
                                                                    DateTimePickerType
                                                                        .datetime,
                                                                options:
                                                                    const BoardDateTimeOptions(
                                                                        languages:
                                                                            BoardPickerLanguages(
                                                                  locale: 'vi',
                                                                  today:
                                                                      'Hôm nay',
                                                                  tomorrow:
                                                                      'Ngày mai',
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
                                                      style:
                                                          TextButton.styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                      ),
                                                      onPressed: () async {
                                                        final result =
                                                            await showBoardDateTimePicker(
                                                                context:
                                                                    context,
                                                                pickerType:
                                                                    DateTimePickerType
                                                                        .datetime,
                                                                options:
                                                                    const BoardDateTimeOptions(
                                                                        languages:
                                                                            BoardPickerLanguages(
                                                                  locale: 'vi',
                                                                  today:
                                                                      'Hôm nay',
                                                                  tomorrow:
                                                                      'Ngày mai',
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
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 15, 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Tôi tự đến lấy xe",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  SizedBox(height: 3),
                                                  Text(
                                                    '${widget.car.addressDistrict}, ${widget.car.addressCity}',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                  color:
                                                      Constants.primaryColor),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
                                    Text(
                                        widget.car.transmission == 'automatic'
                                            ? 'Số tự động'
                                            : 'Số sàn',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
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
                                    Text(widget.car.carSeat + ' ghế',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
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
                                    Text(
                                        widget.car.fuel == "gasoline"
                                            ? 'Xăng'
                                            : widget.car.fuel == 'diesel'
                                                ? 'Dầu Diesel'
                                                : 'Điện',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.car.description != null &&
                                          widget.car.description != ""
                                      ? widget.car.description!
                                      : "Không có mô tả",
                                  maxLines: isExpanded ? null : 4,
                                  overflow: isExpanded
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 5),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i < amenities.length ~/ 2;
                                          i++)
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Image.asset(
                                                amenities[i]['iconPath'],
                                                color: Constants.primaryColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(amenities[i]['name']),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (int i = amenities.length ~/ 2;
                                          i < amenities.length;
                                          i++)
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Image.asset(
                                                amenities[i]['iconPath'],
                                                color: Constants.primaryColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(amenities[i]['name']),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                    ],
                                  )
                                ],
                              ),
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
                              "Vị trí xe",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                '${widget.car.addressRoad}, ${widget.car.addressDistrict}, ${widget.car.addressCity}'),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
                                        child: userDetail.imageAvatar != null &&
                                                userDetail
                                                    .imageAvatar!.isNotEmpty
                                            ? Image.network(
                                                userDetail.imageAvatar!,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                    "lib/assets/images/no_image.png",
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              )
                                            : Image.asset(
                                                "lib/assets/images/no_avatar.png"),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userDetail.name,
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ))
        ]),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          color: Constants.primaryColor.withOpacity(0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(Utils.formatNumber(int.parse(widget.car.price!)),
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
                    Get.to(() => ConfirmRentalScreen(
                        car: widget.car,
                        userModel: userModel,
                        fromDate: fromDate,
                        toDate: toDate));
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
