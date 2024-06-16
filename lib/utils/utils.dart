import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  static Future<Uint8List?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      final imageBytes = await image.readAsBytes();
      return Uint8List.fromList(imageBytes);
    }

    return null;
  }

  static Future<void> uploadImage(image, folder, type, collection) async {
    if (image != null) {
      try {
        // Tạo tên tệp duy nhất cho hình ảnh
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        // Tải hình ảnh lên Firebase Storage
        await firebase_storage.FirebaseStorage.instance
            .ref('images/$folder/$fileName.png')
            .putData(image!);

        // Lấy URL của hình ảnh sau khi tải lên
        String imageUrl = await firebase_storage.FirebaseStorage.instance
            .ref('images/$folder/$fileName.png')
            .getDownloadURL();

        // Lưu URL của hình ảnh vào Firestore
        await FirebaseFirestore.instance
            .collection(collection)
            .doc(folder)
            .update({type: imageUrl});
      } catch (e) {
        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: const Text(
            "Không thể tải hình ảnh",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          icon: const Icon(Icons.error, color: Colors.white),
          onTap: (_) {
            Get.closeCurrentSnackbar();
          },
        ));
      }
    }
  }

  static deleteImageIfExists(String imageUrl) async {
    try {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.refFromURL(imageUrl);

      await ref.getData();
      await ref.delete();
    } catch (e) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: const Text(
          "Không thể xóa hình ảnh",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    }
  }
}
