import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/rental_controller.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/rental_user_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/car/confirm_rental_screen.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/screens/profile/profile_display_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';
import 'package:vehicle_rental_app/widgets/header_details_car.dart';
import 'package:vehicle_rental_app/widgets/rating_rental.dart';

class CarDetailsScreen extends StatefulWidget {
  final CarModel car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  final userController = Get.put(UserController());
  final rentalController = Get.put(RentalController());

  late UserModel owner;
  late UserModel renter;

  List<Map<String, dynamic>> amenities = [];

  DateTime fromDate = DateTime.now().add(const Duration(days: 1));
  DateTime toDate = DateTime.now().add(const Duration(days: 2));
  int days = 1;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

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

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HeaderDetailsCar(car: widget.car),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: FutureBuilder(
                future: Future.wait([
                  userController.getUserByUsername(widget.car.email!),
                  userController.getUserData()
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingScreen();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    UserModel userOwner = snapshot.data![0] as UserModel;
                    UserModel userRenter = snapshot.data![1] as UserModel;

                    owner = userOwner;
                    renter = userRenter;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.car.carInfoModel,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SizedBox(
                              width: 13,
                              height: 13,
                              child: Image.asset(
                                "lib/assets/icons/star.png",
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(widget.car.star != 0 &&
                                    widget.car.totalRental != 0
                                ? (widget.car.star / widget.car.totalRental)
                                    .toStringAsFixed(1)
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
                            Text('${widget.car.totalRental} chuyến'),
                          ],
                        ),
                        const SizedBox(height: 10),
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
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                                            const Text("Nhận xe"),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(0),
                                              ),
                                              onPressed: () async {
                                                final result =
                                                    await showBoardDateTimePicker(
                                                        context: context,
                                                        initialDate: fromDate,
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
                                                  if (result.isBefore(
                                                      DateTime.now())) {
                                                    Utils.showSnackBar(
                                                      "Thời gian nhận xe phải lớn hơn hôm nay.",
                                                      Colors.red,
                                                      Icons.error,
                                                    );
                                                  } else if (result
                                                      .isAfter(toDate)) {
                                                    Utils.showSnackBar(
                                                      "Thời gian nhận xe phải nhỏ hơn thời gian trả xe.",
                                                      Colors.red,
                                                      Icons.error,
                                                    );
                                                  } else {
                                                    setState(() {
                                                      Duration difference =
                                                          toDate.difference(
                                                              fromDate);

                                                      if (difference.inHours %
                                                                  24 ==
                                                              0 &&
                                                          difference.inMinutes %
                                                                  60 ==
                                                              0) {
                                                        days =
                                                            difference.inDays;
                                                        if (days == 0) {
                                                          Utils.showSnackBar(
                                                            "Thời gian thuê xe ít nhất 1 ngày.",
                                                            Colors.red,
                                                            Icons.error,
                                                          );
                                                          return;
                                                        }
                                                      } else {
                                                        days =
                                                            difference.inDays +
                                                                1;
                                                      }
                                                      fromDate = result;
                                                    });
                                                  }
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
                                            const Text("Trả xe"),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(0),
                                              ),
                                              onPressed: () async {
                                                final result =
                                                    await showBoardDateTimePicker(
                                                        context: context,
                                                        initialDate: toDate,
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
                                                  if (result
                                                      .isBefore(fromDate)) {
                                                    Utils.showSnackBar(
                                                      "Thời gian trả xe phải lớn hơn thời gian nhận xe!",
                                                      Colors.red,
                                                      Icons.error,
                                                    );
                                                  } else {
                                                    setState(() {
                                                      Duration difference =
                                                          toDate.difference(
                                                              fromDate);

                                                      if (difference.inHours %
                                                                  24 ==
                                                              0 &&
                                                          difference.inMinutes %
                                                                  60 ==
                                                              0) {
                                                        days =
                                                            difference.inDays;
                                                        if (days == 0) {
                                                          Utils.showSnackBar(
                                                            "Thời gian thuê xe ít nhất 1 ngày.",
                                                            Colors.red,
                                                            Icons.error,
                                                          );
                                                          return;
                                                        }
                                                      } else {
                                                        days =
                                                            difference.inDays +
                                                                1;
                                                      }
                                                      toDate = result;
                                                    });
                                                  }
                                                }
                                              },
                                              child: Text(
                                                BoardDateFormat(
                                                        'HH:mm dd/MM/yyyy')
                                                    .format(toDate),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Text("Số ngày: $days ngày"),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Địa điểm giao nhận xe",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 15, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: null,
                                          groupValue: null,
                                          onChanged: (value) {},
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Tôi tự đến lấy xe",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                widget.car.address,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: null,
                                                overflow: TextOverflow.visible,
                                              )
                                            ],
                                          ),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(height: 1),
                        const SizedBox(height: 20),
                        const Text(
                          "Đặc điểm",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
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
                                const SizedBox(height: 10),
                                const Text(
                                  "Truyền động",
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.car.transmission == 'automatic'
                                      ? 'Số tự động'
                                      : 'Số sàn',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
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
                                const SizedBox(height: 10),
                                const Text(
                                  "Số ghế",
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${widget.car.carSeat} ghế',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
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
                                const SizedBox(height: 10),
                                const Text(
                                  "Nhiên liệu",
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.car.fuel == "gasoline"
                                      ? 'Xăng'
                                      : widget.car.fuel == 'diesel'
                                          ? 'Dầu Diesel'
                                          : 'Điện',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(height: 1),
                        const SizedBox(height: 20),
                        const Text(
                          "Mô tả",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
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
                            const SizedBox(height: 5),
                            widget.car.description != null &&
                                    widget.car.description != ""
                                ? GestureDetector(
                                    onTap: toggleExpanded,
                                    child: Text(
                                      isExpanded ? 'Thu gọn' : 'Xem thêm',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Constants.primaryColor,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(height: 1),
                        const SizedBox(height: 20),
                        const Text(
                          "Các tiện nghi trên xe",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                      i < amenities.length ~/ 2;
                                      i++)
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 6),
                                      child: Row(
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
                                          const SizedBox(width: 8),
                                          Text(amenities[i]['name']),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = amenities.length ~/ 2;
                                      i < amenities.length;
                                      i++)
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 6),
                                      child: Row(
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
                                          const SizedBox(width: 8),
                                          Text(amenities[i]['name']),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(height: 1),
                        const SizedBox(height: 20),
                        const Text(
                          "Vị trí xe",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(widget.car.address),
                        const SizedBox(height: 20),
                        const Divider(height: 1),
                        const SizedBox(height: 20),
                        const Text(
                          "Chủ xe",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
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
                              Get.to(
                                () => ProfileDisplayScreen(
                                  userModel: userOwner,
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                    child: userOwner.imageAvatar != null &&
                                            userOwner.imageAvatar!.isNotEmpty
                                        ? Image.network(
                                            userOwner.imageAvatar!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                "lib/assets/images/no_image.png",
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
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userOwner.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
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
                                          const SizedBox(width: 3),
                                          Text(userOwner.star != 0 &&
                                                  userOwner.totalRental != 0
                                              ? (userOwner.star /
                                                      userOwner.totalRental)
                                                  .toStringAsFixed(1)
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
                                              "${userOwner.totalRental} chuyến"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(height: 1),
                        const SizedBox(height: 20),
                        const Text(
                          "Đánh giá từ khách thuê",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: FutureBuilder(
                            future: RentalController.instance
                                .getListRentalModelByCar(widget.car.id!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return LoadingScreen();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                List<RentalUserModel>? listRentalUser =
                                    snapshot.data as List<RentalUserModel>;
                                return Column(
                                  children: listRentalUser.map((rentalUser) {
                                    return Column(
                                      children: [
                                        RatingRental(
                                            rentalUserModel: rentalUser),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                );
                              } else if (!snapshot.hasData) {
                                return Text("Chưa có đánh giá.");
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        color: Constants.primaryColor.withOpacity(0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  Utils.formatNumber(int.parse(widget.car.price!)),
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Text(" / ngày")
              ],
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  if (renter.isRented) {
                    Utils.showSnackBar("Bạn đang thuê một chiếc xe khác.",
                        Colors.red, Icons.error);
                  } else {
                    Get.to(() => ConfirmRentalScreen(
                        car: widget.car,
                        userModel: owner,
                        fromDate: fromDate,
                        toDate: toDate,
                        days: days));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.primaryColor,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                child: const Text("Thuê xe"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
