import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/car/more_cars_screen.dart';
import 'package:vehicle_rental_app/screens/car/rental_screen.dart';
import 'package:vehicle_rental_app/screens/profile/profile_screen.dart';
import 'package:vehicle_rental_app/screens/widgets/car_card.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Car {
  final String name;
  final String year;
  final String color;

  Car({
    required this.name,
    required this.year,
    required this.color,
  });
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(days: 1));

  final List<Car> cars = [
    Car(name: 'Toyota Camry', year: '2023', color: 'Silver'),
    Car(name: 'Honda Accord', year: '2022', color: 'Black'),
    Car(name: 'Ford Mustang', year: '2024', color: 'Red'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const ProfileScreen());
                            },
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                child: Image.asset(
                                  "lib/assets/images/no_avatar.png",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Duy",
                            style: TextStyle(fontSize: 17),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications_none),
                          ),
                          const VerticalDivider(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.message_outlined),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
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
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Constants.primaryColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Tìm xe",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 24.0,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    "Địa điểm",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const TextField(
                                decoration: InputDecoration(
                                  hintText: 'Nhập địa điểm bạn muốn thuê xe',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 32),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 24.0,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    "Thời gian thuê",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Từ ngày",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              side: BorderSide(
                                                color: Constants.primaryColor,
                                              )),
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
                                            BoardDateFormat('HH:mm dd/MM/yyyy')
                                                .format(toDate),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Đến ngày",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              side: BorderSide(
                                                color: Constants.primaryColor,
                                              )),
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
                                                toDate = result;
                                              });
                                            }
                                          },
                                          child: Text(
                                            BoardDateFormat('HH:mm dd/MM/yyyy')
                                                .format(toDate),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(() =>
                                        MoreCarsScreen(title_screen: "Tìm xe"));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constants.primaryColor,
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                    ),
                                  ),
                                  child: const Text(
                                    "TÌM XE",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Xe dành cho bạn",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(() => const MoreCarsScreen(
                                title_screen: "Tất cả xe"));
                          },
                          child: Text(
                            "Xem thêm",
                            style: TextStyle(
                              color: Constants.primaryColor,
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          width: MediaQuery.of(context).size.width - 40,
                          child: CarCard(car: cars[0]),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          width: MediaQuery.of(context).size.width - 40,
                          child: CarCard(car: cars[0]),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          width: MediaQuery.of(context).size.width - 40,
                          child: CarCard(car: cars[0]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: Image.asset(
                          "lib/assets/images/car_footer.png",
                        ).image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Bạn muốn cho thuê xe?",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Hơn 1000 chủ xe đang cho thuê xe trên ứng dụng.\n"
                                "Đăng ký để trở thành đối tác của chúng tôi ngay hôm nay để gia tăng thu nhập.",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(const RentalScreen());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constants.primaryColor,
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                  ),
                                  child: const Text(
                                    "Đăng ký ngay",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
