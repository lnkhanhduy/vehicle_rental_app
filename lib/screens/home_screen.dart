import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/car_controller.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/car/more_cars_screen.dart';
import 'package:vehicle_rental_app/screens/profile/change_profile_screen.dart';
import 'package:vehicle_rental_app/screens/register_car/info_rental_screen.dart';
import 'package:vehicle_rental_app/screens/user/notification_screen.dart';
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
                      UserController.instance.getUserData(),
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
                                          Get.to(() =>
                                              const ChangeProfileScreen());
                                        },
                                        child: SizedBox(
                                          width: 48,
                                          height: 48,
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
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 7),
                                      Text(
                                        userModel.name,
                                        style: const TextStyle(fontSize: 15),
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
                              const SizedBox(height: 30),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    )),
                                child: Row(children: [
                                  Expanded(
                                    child: TextField(
                                      controller: keyword,
                                      onSubmitted: (value) {
                                        Get.to(() => MoreCarsScreen(
                                            keyword: value.trim()));
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Tìm xe",
                                        hintStyle: TextStyle(fontSize: 15),
                                        contentPadding:
                                            EdgeInsets.only(left: 13),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Get.to(() => MoreCarsScreen(
                                            keyword: keyword.text.trim()));
                                      },
                                      icon: Icon(Icons.search))
                                ]),
                              ),
                              const SizedBox(height: 15),
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
                              const SizedBox(height: 6),
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
                                                Get.to(InfoRentalScreen(
                                                    isToHome: true));
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
