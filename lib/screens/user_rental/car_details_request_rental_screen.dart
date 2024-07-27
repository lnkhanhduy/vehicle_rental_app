import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/rental_controller.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/rental_car_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/car/rating_car_screen.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/screens/profile/profile_display_screen.dart';
import 'package:vehicle_rental_app/screens/success_screen.dart';
import 'package:vehicle_rental_app/screens/user/history_screen.dart';
import 'package:vehicle_rental_app/screens/user_rental/request_rental_car_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';
import 'package:vehicle_rental_app/widgets/header_details_car.dart';

class CarDetailsRequestRentalScreen extends StatefulWidget {
  final RentalCarModel rentalCarModel;
  final bool isOwner;
  final bool isHistory;

  const CarDetailsRequestRentalScreen(
      {super.key,
      required this.rentalCarModel,
      this.isOwner = false,
      this.isHistory = false});

  @override
  State<CarDetailsRequestRentalScreen> createState() =>
      _CarDetailsRequestRentalScreenState();
}

class _CarDetailsRequestRentalScreenState
    extends State<CarDetailsRequestRentalScreen> {
  final userController = Get.put(UserController());
  final rentalController = Get.put(RentalController());

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(days: 1));
  int days = 1;

  List<Map<String, dynamic>> amenities = [];

  bool isExpanded = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fromDate = DateTime.parse(widget.rentalCarModel.rentalModel.fromDate);
    toDate = DateTime.parse(widget.rentalCarModel.rentalModel.toDate);

    Duration difference = toDate.difference(fromDate);
    if (difference.inHours % 24 == 0 && difference.inMinutes % 60 == 0) {
      days = difference.inDays;
    } else {
      days = difference.inDays + 1;
    }

    amenities = [
      {
        'name': 'Bản đồ',
        'iconPath': 'lib/assets/icons/map.png',
        'isAvailable': widget.rentalCarModel.carModel.map
      },
      {
        'name': 'Camera hành trình',
        'iconPath': 'lib/assets/icons/cctv.png',
        'isAvailable': widget.rentalCarModel.carModel.cctv
      },
      {
        'name': 'Cảm biến va chạm',
        'iconPath': 'lib/assets/icons/sensor.png',
        'isAvailable': widget.rentalCarModel.carModel.sensor
      },
      {
        'name': 'Khe cắm USB',
        'iconPath': 'lib/assets/icons/usb.png',
        'isAvailable': widget.rentalCarModel.carModel.usb
      },
      {
        'name': 'Màn hình',
        'iconPath': 'lib/assets/icons/tablet.png',
        'isAvailable': widget.rentalCarModel.carModel.tablet
      },
      {
        'name': 'Túi khí an toàn',
        'iconPath': 'lib/assets/icons/air_bag.png',
        'isAvailable': widget.rentalCarModel.carModel.airBag
      },
      {
        'name': 'Bluetooth',
        'iconPath': 'lib/assets/icons/bluetooth.png',
        'isAvailable': widget.rentalCarModel.carModel.bluetooth
      },
      {
        'name': 'Camera lùi',
        'iconPath': 'lib/assets/icons/camera.png',
        'isAvailable': widget.rentalCarModel.carModel.cameraBack
      },
      {
        'name': 'Lốp dự phòng',
        'iconPath': 'lib/assets/icons/tire.png',
        'isAvailable': widget.rentalCarModel.carModel.tire
      },
      {
        'name': 'ETC',
        'iconPath': 'lib/assets/icons/etc.png',
        'isAvailable': widget.rentalCarModel.carModel.etc
      },
    ];

    amenities = amenities.where((amenity) => amenity['isAvailable']).toList();
  }

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HeaderDetailsCar(car: widget.rentalCarModel.carModel),
          SliverFillRemaining(
            hasScrollBody: false,
            child: isLoading == true
                ? LoadingScreen()
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    constraints: const BoxConstraints.expand(),
                    color: Colors.white,
                    child: FutureBuilder(
                      future: userController.getUserByUsername(widget.isOwner
                          ? widget.rentalCarModel.rentalModel.email!
                          : widget.rentalCarModel.rentalModel.idOwner!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LoadingScreen();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.connectionState ==
                                ConnectionState.done &&
                            snapshot.hasData) {
                          UserModel userDetail = snapshot.data!;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.rentalCarModel.carModel.carInfoModel,
                                style: const TextStyle(
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
                                  Text(widget.rentalCarModel.carModel.star !=
                                              0 &&
                                          widget.rentalCarModel.carModel
                                                  .totalRental !=
                                              0
                                      ? (widget.rentalCarModel.carModel.star /
                                              widget.rentalCarModel.carModel
                                                  .totalRental)
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
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                      '${widget.rentalCarModel.carModel.totalRental} chuyến'),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 15, 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
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
                                                  Text(
                                                    BoardDateFormat(
                                                            'HH:mm dd/MM/yyyy')
                                                        .format(fromDate),
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
                                                  Text(
                                                    BoardDateFormat(
                                                            'HH:mm dd/MM/yyyy')
                                                        .format(toDate),
                                                    style: const TextStyle(
                                                      color: Colors.black,
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        widget.rentalCarModel.carModel.address,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Divider(height: 1),
                              const SizedBox(height: 20),
                              const Text(
                                "Tổng tiền",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${Utils.formatNumber(int.parse(widget.rentalCarModel.carModel.price!) * days)} VND',
                                style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Row(
                                children: [
                                  Icon(Icons.credit_card_outlined,
                                      size: 18, color: Colors.grey),
                                  SizedBox(width: 3),
                                  Text(
                                    "Phương thức thanh toán",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Text("Thanh toán khi nhận xe",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        widget.rentalCarModel.carModel
                                                    .transmission ==
                                                'automatic'
                                            ? 'Số tự động'
                                            : 'Số sàn',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
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
                                        '${widget.rentalCarModel.carModel.carSeat} ghế',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
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
                                        widget.rentalCarModel.carModel.fuel ==
                                                "gasoline"
                                            ? 'Xăng'
                                            : widget.rentalCarModel.carModel
                                                        .fuel ==
                                                    'diesel'
                                                ? 'Dầu Diesel'
                                                : 'Điện',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
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
                                    widget.rentalCarModel.carModel
                                                    .description !=
                                                null &&
                                            widget.rentalCarModel.carModel
                                                    .description !=
                                                ""
                                        ? widget.rentalCarModel.carModel
                                            .description!
                                        : "Không có mô tả",
                                    maxLines: isExpanded ? null : 4,
                                    overflow: isExpanded
                                        ? TextOverflow.visible
                                        : TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 5),
                                  widget.rentalCarModel.carModel.description !=
                                              null &&
                                          widget.rentalCarModel.carModel
                                                  .description !=
                                              ""
                                      ? GestureDetector(
                                          onTap: _toggleExpanded,
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
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(
                                                    amenities[i]['iconPath'],
                                                    color:
                                                        Constants.primaryColor,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (int i = amenities.length ~/ 2;
                                            i < amenities.length;
                                            i++)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(
                                                    amenities[i]['iconPath'],
                                                    color:
                                                        Constants.primaryColor,
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
                              Text(widget.rentalCarModel.carModel.address),
                              const SizedBox(height: 20),
                              const Divider(height: 1),
                              const SizedBox(height: 20),
                              if (widget.isOwner)
                                const Text(
                                  "Người thuê",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              if (!widget.isOwner)
                                Text(
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
                                        userModel: userDetail,
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
                                          child:
                                              userDetail.imageAvatar != null &&
                                                      userDetail.imageAvatar!
                                                          .isNotEmpty
                                                  ? Image.network(
                                                      userDetail.imageAvatar!,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
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
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userDetail.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
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
                                                    Text(userDetail.star != 0 &&
                                                            userDetail
                                                                    .totalRental !=
                                                                0
                                                        ? (userDetail.star /
                                                                userDetail
                                                                    .totalRental)
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
                                                        color: Constants
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                        '${userDetail.totalRental} chuyến'),
                                                  ],
                                                ),
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
                                "Lời nhắn",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 15),
                              Text(widget.rentalCarModel.rentalModel.message!
                                      .isNotEmpty
                                  ? widget.rentalCarModel.rentalModel.message!
                                  : "Không có lời nhắn"),
                              const SizedBox(height: 20),
                              const Divider(height: 1),
                              const SizedBox(height: 20),
                              if (widget.rentalCarModel.rentalModel.status ==
                                      "approved" &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.fromDate)
                                      .isAfter(DateTime.now()) &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.toDate)
                                      .isAfter(DateTime.now()))
                                const Text(
                                  "Chờ nhận xe",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.blue),
                                ),
                              if (widget.rentalCarModel.rentalModel.status ==
                                      "approved" &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.fromDate)
                                      .isBefore(DateTime.now()) &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.toDate)
                                      .isAfter(DateTime.now()))
                                const Text(
                                  "Đang được thuê",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.green),
                                ),
                              if (widget.rentalCarModel.rentalModel.status ==
                                      "approved" &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.fromDate)
                                      .isBefore(DateTime.now()) &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.toDate)
                                      .isBefore(DateTime.now()))
                                const Text(
                                  "Chờ đánh giá",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.blue),
                                ),
                              if (widget.rentalCarModel.rentalModel.status ==
                                  "paid")
                                const Text(
                                  "Đã trả",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.green),
                                ),
                              if (widget.rentalCarModel.rentalModel.status ==
                                      "waiting" &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.fromDate)
                                      .isAfter(DateTime.now()) &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.toDate)
                                      .isAfter(DateTime.now()))
                                const Text(
                                  "Chờ phản hồi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.amber),
                                ),
                              if (widget.rentalCarModel.rentalModel.status == "canceled" ||
                                  widget.rentalCarModel.rentalModel.status ==
                                      "rejected" ||
                                  (widget.rentalCarModel.rentalModel.status ==
                                          "waiting" &&
                                      DateTime.parse(widget.rentalCarModel
                                              .rentalModel.fromDate)
                                          .isBefore(DateTime.now())))
                                const Text(
                                  "Đã hủy",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.red),
                                ),
                              if (widget.rentalCarModel.rentalModel.status ==
                                  "paid")
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    const Divider(height: 1),
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Đánh giá",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
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
                                        Text(
                                          widget.rentalCarModel.rentalModel.star
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                        'Nhận xét: ${widget.rentalCarModel.rentalModel.review ?? "Không có nhận xét."}'),
                                  ],
                                ),
                              const SizedBox(height: 20),
                              const Divider(height: 1),
                              const SizedBox(height: 20),
                              if (widget.isOwner == true &&
                                  widget.rentalCarModel.rentalModel.status ==
                                      "waiting" &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.fromDate)
                                      .isAfter(DateTime.now()) &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.toDate)
                                      .isAfter(DateTime.now()))
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          showConfirmationCancel(widget
                                              .rentalCarModel.rentalModel.id!);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          ),
                                        ),
                                        child: const Text("Từ chối"),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (widget.rentalCarModel.carModel
                                                  .isRented ==
                                              true) {
                                            Utils.showSnackBar(
                                                "Xe đang được cho thuê.",
                                                Colors.red,
                                                Icons.error);
                                          } else if (userDetail.isRented ==
                                              true) {
                                            Utils.showSnackBar(
                                                "Người dùng này đang thuê một chiếc xe khác.",
                                                Colors.red,
                                                Icons.error);
                                          } else {
                                            showConfirmationApprove(
                                                widget.rentalCarModel
                                                    .rentalModel.id!,
                                                widget.rentalCarModel
                                                    .rentalModel.email!,
                                                widget.rentalCarModel.carModel
                                                    .id!);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Constants.primaryColor,
                                          foregroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                        ),
                                        child: const Text("Cho thuê"),
                                      ),
                                    ),
                                  ],
                                ),
                              if (widget.isOwner != true &&
                                  widget.rentalCarModel.rentalModel.status ==
                                      "approved" &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.fromDate)
                                      .isBefore(DateTime.now()))
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: ElevatedButton(
                                        onPressed: () => Get.to(() =>
                                            RatingCarScreen(
                                                idRental: widget.rentalCarModel
                                                    .rentalModel.id!,
                                                idUserRental: widget
                                                    .rentalCarModel
                                                    .rentalModel
                                                    .idOwner!,
                                                idCar: widget.rentalCarModel
                                                    .rentalModel.idCar)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Constants.primaryColor,
                                          foregroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                        ),
                                        child: const Text("Trả xe"),
                                      ),
                                    ),
                                  ],
                                ),
                              if (widget.isOwner != true &&
                                  (widget.rentalCarModel.rentalModel.status ==
                                          "waiting" ||
                                      widget.rentalCarModel.rentalModel
                                              .status ==
                                          "approved") &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.fromDate)
                                      .isAfter(DateTime.now()) &&
                                  DateTime.parse(widget
                                          .rentalCarModel.rentalModel.toDate)
                                      .isAfter(DateTime.now()))
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          bool result = await rentalController
                                              .cancelRequestByUser(
                                                  widget.rentalCarModel
                                                      .rentalModel.id!,
                                                  widget.rentalCarModel
                                                      .rentalModel.idCar,
                                                  widget.rentalCarModel
                                                      .rentalModel.email!);
                                          if (result) {
                                            Utils.showSnackBar(
                                                "Hủy thuê xe thành công.",
                                                Colors.green,
                                                Icons.check);
                                            Get.to(() => HistoryScreen());
                                          }
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          ),
                                        ),
                                        child: const Text("Hủy thuê"),
                                      ),
                                    ),
                                  ],
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
    );
  }

  Future<void> showConfirmationApprove(
      String idRental, String idUserRental, String idCar) async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Chấp nhận yêu cầu thuê xe'),
          content: const Text('Bạn có chắc muốn cho thuê xe không?'),
          actions: [
            TextButton(
              child: const Text('Đóng', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child:
                  const Text('Cho thuê', style: TextStyle(color: Colors.green)),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                Navigator.of(context).pop(true);
                bool result = await rentalController.approveRequest(
                    idRental, idUserRental, idCar);

                if (result) {
                  await Utils.sendEmailNotification(
                    "Thông báo đặt xe thành công",
                    Utils.templateApproveOrderCar(
                        widget.rentalCarModel.carModel.carInfoModel,
                        widget.rentalCarModel.rentalModel.fromDate,
                        widget.rentalCarModel.rentalModel.toDate,
                        widget.rentalCarModel.carModel.address,
                        Utils.formatNumber(int.parse(
                                    widget.rentalCarModel.carModel.price!) *
                                days)
                            .toString()),
                    widget.rentalCarModel.rentalModel.email!,
                  );

                  Get.to(
                    () => const SuccessScreen(
                        title: "Chấp nhận cho thuê xe thành công",
                        content:
                            "Chấp nhận cho thuê xe thành công. Người thuê sẽ sớm đến lấy xe."),
                  );
                }

                setState(() {
                  isLoading = false;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showConfirmationCancel(String idRental) async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Từ chối yêu cầu thuê xe'),
          content: const Text('Bạn có chắc muốn từ chối cho thuê xe không?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Từ chối', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                Navigator.of(context).pop(true);
                bool result = await rentalController.cancelRequest(idRental);
                if (result) {
                  await Utils.sendEmailNotification(
                    "Thông báo đặt xe thất bại",
                    Utils.templateRejectOrderCar(
                        widget.rentalCarModel.carModel.carInfoModel),
                    widget.rentalCarModel.rentalModel.email!,
                  );

                  Utils.showSnackBar(
                    "Bạn đã từ chối cho thuê xe.",
                    Colors.green,
                    Icons.check,
                  );
                  Get.to(() => RequestRentalCarScreen());
                }

                setState(() {
                  isLoading = false;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
