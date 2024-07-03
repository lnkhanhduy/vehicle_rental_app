import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/car_controller.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/car/more_cars_screen.dart';
import 'package:vehicle_rental_app/screens/user/account_screen.dart';
import 'package:vehicle_rental_app/screens/user/notification_screen.dart';
import 'package:vehicle_rental_app/screens/user_rental/info_rental_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/widgets/car_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final keyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                constraints: const BoxConstraints.expand(),
                color: Colors.white,
                child: FutureBuilder(
                    future: Future.wait([
                      CarController.instance.getCarHomeScreen(),
                      UserController.instance.getUserData()
                    ]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          List<CarModel>? cars;

                          UserModel? userModel;
                          if (snapshot.data![0] != null) {
                            cars = snapshot.data![0] as List<CarModel>;
                          }
                          if (snapshot.data![1] != null) {
                            userModel = snapshot.data![1] as UserModel;
                          }

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => const AccountScreen());
                                        },
                                        child: SizedBox(
                                          width: 54,
                                          height: 54,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(100)),
                                            child: (userModel!.imageAvatar !=
                                                        null &&
                                                    userModel.imageAvatar != "")
                                                ? Image(
                                                    image: Image.network(
                                                    userModel.imageAvatar!,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        "lib/assets/images/no_avatar.png",
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  ).image)
                                                : Image.asset(
                                                    "lib/assets/images/no_avatar.png",
                                                  ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        userModel.name,
                                        style: const TextStyle(fontSize: 16),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.to(() => const NotificationScreen());
                                    },
                                    icon: const Icon(Icons.notifications_none),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.search,
                                                size: 18,
                                                color: Colors.black,
                                              ),
                                              SizedBox(width: 8.0),
                                              Text(
                                                "Từ khóa",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          TextField(
                                            controller: keyword,
                                            decoration: const InputDecoration(
                                              hintText: 'Nhập từ khóa tìm xe',
                                              hintStyle:
                                                  TextStyle(fontSize: 15),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 26,
                                                      vertical: 0),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 40,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Get.to(() => MoreCarsScreen(
                                                    keyword:
                                                        keyword.text.trim()));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Constants.primaryColor,
                                                foregroundColor: Colors.white,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                ),
                                              ),
                                              child: const Text(
                                                "TÌM XE",
                                                style: TextStyle(
                                                  fontSize: 16,
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
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Xe dành cho bạn",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(() =>
                                            const MoreCarsScreen(keyword: ""));
                                      },
                                      child: Text(
                                        "Xem thêm",
                                        style: TextStyle(
                                          color: Constants.primaryColor,
                                        ),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              cars!.isNotEmpty
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: cars.map((car) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            child: CarCard(car: car),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  : const Text(
                                      "Tất cả các xe đang được cho thuê. Vui lòng quay lại sau."),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                Get.to(
                                                    const InfoRentalScreen());
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Constants.primaryColor,
                                                foregroundColor: Colors.white,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
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
                          );
                        } else {
                          return const Center(
                            child: Text(
                              "Lỗi dữ liệu",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          );
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    })),
          ),
        ],
      ),
    );
  }
}
