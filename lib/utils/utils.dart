import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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

  //Send email
  static Future<bool> sendEmailNotification(
      String subject, String html, String email) async {
    try {
      final userEmail = "khanhduyhbvl20011@gmail.com";
      final accessToken = "oowqnyztxmpnsqbh";
      final smtpServer = gmail(userEmail, accessToken);

      Message message = Message();
      message.from = Address(userEmail, "no-reply@vehiclerentalapp.com");
      message.recipients.add(email);
      message.subject = subject + " - VehicleRentalApp";
      message.html = html;

      await send(message, smtpServer);
      return true;
    } catch (e) {
      return false;
    }
  }

  //Template request order car success
  static String templateRequestOrderCar(String name, String fromDate,
      String toDate, String address, String price) {
    String html = '''
  <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;">
    <h2 style="color: #4CAF50; text-align: center;">Gửi yêu cầu thuê xe thành công</h2>
    <p style="font-size: 16px;">Xin chào,</p>
    <p style="font-size: 16px;">Bạn đã gửi yêu cầu thuê xe thành công. Chủ xe sẽ xem xét yêu cầu và liên hệ với bạn trong thời gian sớm nhất. Thông tin đặt xe như sau:</p>
    <table style="width: 100%; margin-top: 20px;">
      <tr>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;"><strong>Tên xe:</strong></td>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;">$name</td>
      </tr>
      <tr>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;"><strong>Thời gian nhận xe:</strong></td>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;">$fromDate</td>
      </tr>
      <tr>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;"><strong>Thời gian trả xe:</strong></td>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;">$toDate</td>
      </tr>
      <tr>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;"><strong>Địa điểm nhận xe:</strong></td>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;">$address</td>
      </tr>
      <tr>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;"><strong>Giá thuê xe:</strong></td>
        <td style="padding: 10px; border-bottom: 1px solid #ddd; color: red;"><strong>$price</strong></td>
      </tr>
    </table>
    <p style="font-size: 16px;margin-top: 20px;">Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!</p>
    <p style="font-size: 16px;">Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm thông tin, xin vui lòng liên hệ với chúng tôi qua các phương thức dưới đây:</p>
    <p style="font-size: 16px;"><strong>Email:</strong> support@example.com</p>
    <p style="font-size: 16px;"><strong>Số điện thoại:</strong> 0123 456 789</p>
    <p style="font-size: 16px;">Trân trọng,</p>
    <p style="font-size: 16px;"><strong>Đội ngũ hỗ trợ</strong></p>
  </div>
  ''';
    return html;
  }

  // Template approve order car success
  static String templateApproveOrderCar(String name, String fromDate,
      String toDate, String address, String price) {
    String html = '''
     <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;">
      <h2 style="color: #4CAF50; text-align: center;">Đặt xe thành công</h2>
      <p style="font-size: 16px;">Xin chào,</p>
      <p style="font-size: 16px;">Chúc mừng bạn đã đặt xe thành công. Chủ xe đã duyệt yêu cầu thuê xe của bạn. Thông tin đặt xe như sau:</p>
      <table style="width: 100%; margin-top: 20px;">
        <tr>
          <td style="padding: 10px; border-bottom: 1px solid #ddd;"><strong>Tên xe:</strong></td>
          <td style="padding: 10px; border-bottom: 1px solid #ddd;">$name</td>
        </tr>
        <tr>
          <td style="padding: 10px; border-bottom: 1px solid #ddd;"><strong>Thời gian nhận xe:</strong></td>
          <td style="padding: 10px; border-bottom: 1px solid #ddd;">$fromDate - $toDate</td>
        </tr>
        <tr>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;"><strong>Thời gian trả xe:</strong></td>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;">$toDate</td>
      </tr>
        <tr>
          <td style="padding: 10px; border-bottom: 1px solid #ddd;"><strong>Địa điểm nhận xe:</strong></td>
          <td style="padding: 10px; border-bottom: 1px solid #ddd;">$address</td>
        </tr>
        <tr>
          <td style="padding: 10px; border-bottom: 1px solid #ddd;"><strong>Giá thuê xe:</strong></td>
          <td style="padding: 10px; border-bottom: 1px solid #ddd; color: red;"><strong>$price</strong></td>
        </tr>
      </table>
      <p style="font-size: 16px; margin-top: 20px;">Chúc bạn có một chuyến đi vui vẻ!</p>
      <p style="font-size: 16px;">Nếu bạn có bất kỳ câu hỏi nào, xin vui lòng liên hệ với chúng tôi qua thông tin dưới đây:</p>
      <p style="font-size: 16px;"><strong>Thông tin liên hệ:</strong></p>
      <p style="font-size: 16px;">Email: support@example.com</p>
      <p style="font-size: 16px;">Số điện thoại: 0123 456 789</p>
      <p style="font-size: 16px;">Trân trọng,</p>
      <p style="font-size: 16px;"><strong>Đội ngũ hỗ trợ</strong></p>
    </div>
  ''';
    return html;
  }

  // Template reject order car success
  static String templateRejectOrderCar(String name) {
    String html = '''
  <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;">
    <h2 style="color: #FF0000; text-align: center;">Đặt xe thất bại</h2>
    <p style="font-size: 16px;">Xin chào,</p>
    <p style="font-size: 16px;">Chúng tôi rất tiếc phải thông báo rằng yêu cầu đặt xe của bạn đã bị từ chối. Dưới đây là thông tin chi tiết về yêu cầu của bạn:</p>
    <table style="width: 100%; margin-top: 20px;">
      <tr>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;"><strong>Tên xe:</strong></td>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;">$name</td>
      </tr>
      <tr>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;"><strong>Lý do từ chối:</strong></td>
        <td style="padding: 10px; border-bottom: 1px solid #ddd;">Xe đã được đặt bởi người khác</td>
      </tr>
    </table>
    <p style="font-size: 16px; margin-top: 20px;">Chúng tôi xin lỗi vì sự bất tiện này và rất tiếc không thể đáp ứng yêu cầu của bạn lần này.</p>
    <p style="font-size: 16px;">Nếu bạn có bất kỳ câu hỏi nào hoặc cần hỗ trợ thêm, xin vui lòng liên hệ với chúng tôi.</p>
    <p style="font-size: 16px; margin-top: 20px;"><strong>Thông tin liên hệ:</strong></p>
    <p style="font-size: 16px;">Email: support@example.com</p>
    <p style="font-size: 16px;">Số điện thoại: 0123 456 789</p>
    <p style="font-size: 16px;">Trân trọng,</p>
    <p style="font-size: 16px;"><strong>Đội ngũ hỗ trợ</strong></p>
  </div>
    ''';
    return html;
  }
}
