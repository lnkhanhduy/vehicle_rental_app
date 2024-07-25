import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String title;
  final bool image;
  final double height;
  final double width;
  final Uint8List? imageUnit8List;
  final String? imageUrl;
  final String imageAsset;

  const ImageContainer(
      {super.key,
      required this.title,
      required this.image,
      required this.height,
      required this.width,
      this.imageUnit8List,
      this.imageUrl,
      required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        const SizedBox(height: 10),
        image
            ? Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  image: imageUnit8List != null
                      ? DecorationImage(
                          image: MemoryImage(imageUnit8List!),
                          fit: BoxFit.cover,
                        )
                      : (imageUrl != null && imageUrl!.isNotEmpty)
                          ? DecorationImage(
                              image: Image.network(
                                imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    "lib/assets/images/no_image.png",
                                    fit: BoxFit.cover,
                                  );
                                },
                              ).image,
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: Image.asset(
                              imageAsset,
                            ).image),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              )
            : Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      imageAsset,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
