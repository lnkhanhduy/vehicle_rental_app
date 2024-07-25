import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class HeaderDetailsCar extends StatefulWidget {
  final CarModel car;

  const HeaderDetailsCar({super.key, required this.car});

  @override
  State<HeaderDetailsCar> createState() => _HeaderDetailsCarState();
}

class _HeaderDetailsCarState extends State<HeaderDetailsCar> {
  final userController = Get.put(UserController());
  final PageController imageController = PageController();

  bool isFavoriteCar = false;
  int currentImage = 1;
  List<String> imageNames = [];

  @override
  void initState() {
    super.initState();
    isFavoriteCar = widget.car.isFavorite ?? false;

    imageNames = [
      widget.car.imageCarMain!,
      widget.car.imageCarInside!,
      widget.car.imageCarFront!,
      widget.car.imageCarBack!,
      widget.car.imageCarLeft!,
      widget.car.imageCarRight!,
    ];

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

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white)),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            isFavoriteCar ? Icons.favorite : Icons.favorite_border,
            color: isFavoriteCar ? Constants.primaryColor : Colors.white,
          ),
          onPressed: () async {
            Get.closeCurrentSnackbar();
            await userController.addFavorite(widget.car.id!);

            setState(() {
              isFavoriteCar = !isFavoriteCar;
            });
          },
        ),
      ],
      pinned: true,
    );
  }
}
