import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class Utils {
  // Chọn hình ảnh
  static Future<Uint8List?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      final imageBytes = await image.readAsBytes();
      return Uint8List.fromList(imageBytes);
    }

    return null;
  }

  // Tải hình ảnh
  static Future<void> uploadImage(
      image, folderName, folderId, type, collection) async {
    if (image != null) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Tải hình ảnh lên Firebase Storage
      await firebase_storage.FirebaseStorage.instance
          .ref('$folderName/$folderId/$fileName.png')
          .putData(image!);

      // Lấy URL của hình ảnh sau khi tải lên
      String imageUrl = await firebase_storage.FirebaseStorage.instance
          .ref('$folderName/$folderId/$fileName.png')
          .getDownloadURL();

      // Lưu URL của hình ảnh vào Firestore
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(folderId)
          .update({type: imageUrl});
    }
  }

  // Xóa hình ảnh
  static deleteImageIfExists(String imageUrl) async {
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.refFromURL(imageUrl);

    await ref.getData();
    await ref.delete();
  }

  static String formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed((number % 1000 == 0) ? 0 : 1)}K';
    } else {
      return number.toString();
    }
  }

  // Kiểm tra định dạng email
  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  // Kiểm tra định dạng sdt
  static bool isPhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^(\d{10}|)$');
    return regex.hasMatch(phoneNumber);
  }

  // Kiểm tra xem email đã tồn tại hay chưa
  static Future<bool> isExistPhoneNumber(String phoneNumber) async {
    final isExist = await FirebaseFirestore.instance
        .collection("Users")
        .where("phone", isEqualTo: phoneNumber)
        .get();
    return isExist.docs.isNotEmpty;
  }
}
