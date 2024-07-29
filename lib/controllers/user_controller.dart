import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/chat_model.dart';
import 'package:vehicle_rental_app/models/rental_car_model.dart';
import 'package:vehicle_rental_app/models/rental_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/auth/email_verification_screen.dart';
import 'package:vehicle_rental_app/screens/auth/login_screen.dart';
import 'package:vehicle_rental_app/screens/auth/otp_screen.dart';
import 'package:vehicle_rental_app/screens/layout_admin_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  late final Rx<User?> firebaseUser;
  late bool isAdmin = false;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, setInitialScreen);
  }

  void setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isAdmin = prefs.getBool('isAdmin') ?? false;

      if (isAdmin) {
        Get.offAll(() => const LayoutAdminScreen());
      } else if (user.emailVerified ||
          firebaseUser.value?.emailVerified == true ||
          firebaseUser.value?.providerData[0].providerId == "google.com") {
        Get.offAll(() => const LayoutScreen());
      } else {
        Get.offAll(() => const EmailVerificationScreen());
      }
    }
  }

  String? formatPhoneNumber(String phone) {
    phone = phone.replaceAll(RegExp(r'[^0-9]'), '');

    if (phone.startsWith("0")) {
      return "+84${phone.substring(1)}";
    } else if (phone.startsWith("84")) {
      return "+${phone}";
    } else if (!phone.startsWith("+")) {
      return "+84$phone";
    } else if (phone.startsWith("+84")) {
      return phone;
    }

    return null;
  }

  Future<String?> sendOTP(String phone) async {
    final Completer<String?> completer = Completer<String?>();

    try {
      phone = formatPhoneNumber(phone)!;

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(minutes: 2),
        verificationCompleted: (PhoneAuthCredential credential) async {
          completer.complete(credential.smsCode);
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Error: ${e.message}");
          completer.completeError(e);
        },
        codeSent: (String verificationId, int? resendToken) async {
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          completer.complete(verificationId);
        },
      );
    } catch (e) {
      print("Error: $e");
      completer.completeError(e);
    }

    return completer.future;
  }

  Future<bool> checkOTP(String verificationId, String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final result =
      await FirebaseAuth.instance.signInWithCredential(credential);
      return result.user != null;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<UserModel?> getUserData() async {
    final email = firebaseUser.value?.providerData[0].email;

    if (email != null) {
      try {
        return await getUserByUsername(email);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<UserModel?> getUserByUsername(String username) async {
    if (username.isEmpty) return null;

    try {
      QuerySnapshot snapshot;
      if (Utils.isPhoneNumber(username)) {
        snapshot = await firebaseFirestore
            .collection("Users")
            .where("phone", isEqualTo: username)
            .get();
      } else {
        snapshot = await firebaseFirestore
            .collection("Users")
            .where("email", isEqualTo: username)
            .get();
      }

      if (snapshot.docs.isEmpty) {
        return null;
      }

      final userData = snapshot.docs
          .map((e) =>
          UserModel.fromSnapshot(
              e as DocumentSnapshot<Map<String, dynamic>>))
          .first;
      return userData;
    } catch (e) {
      return null;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      if (username.isEmpty || password.isEmpty || password.length < 6) {
        return false;
      }

      UserModel? user = await getUserByUsername(username);
      if (user == null) {
        return false;
      } else {
        final userLogin = await firebaseAuth.signInWithEmailAndPassword(
            email: user.email, password: password);
        isAdmin = user.isAdmin;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isAdmin', isAdmin);
        setInitialScreen(userLogin.user);
        return true;
      }
    } on FirebaseAuthException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await GoogleSignIn().signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserModel? user = await getUserByUsername(googleSignInAccount.email);

        if (user == null) {
          UserModel newUser = UserModel(
            name: googleSignInAccount.displayName ?? "",
            email: googleSignInAccount.email,
            phone: "",
            password: "",
            isAdmin: false,
          );

          await firebaseFirestore
              .collection("Users")
              .doc(newUser.email)
              .set(newUser.toJson());
        }

        await firebaseAuth.signInWithCredential(credential);
      }
    } on FirebaseAuthException {
      return;
    } catch (e) {
      return;
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      await GoogleSignIn().signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAdmin', false);
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      return;
    }
  }

  Future<void> forgotPassword(String email) async {
    String error = "";
    if (email.isEmpty) {
      error = "Vui lòng nhập email!";
    } else if (!Utils.isValidEmail(email)) {
      error = "Email không hợp lệ!";
    }

    if (error != "") {
      Utils.showSnackBar(error, Colors.red, Icons.error);
    } else {
      try {
        UserModel? userModel = await getUserByUsername(email);

        if (userModel != null && userModel.provider != "password") {
          Utils.showSnackBar(
            "Email được đăng ký bằng tài khoản Google, vui lòng đăng nhập với Google!",
            Colors.amber,
            Icons.warning_amber,
          );
        } else {
          await firebaseAuth.sendPasswordResetEmail(email: email);

          Utils.showSnackBar(
            "Vui lòng kiểm tra email để đặt lại mật khẩu.",
            Colors.green,
            Icons.check,
          );
        }
      } catch (e) {
        return;
      }
    }
  }

  Future<String?> createUser(UserModel user) async {
    String error = "";
    if (user.name.isEmpty ||
        user.email.isEmpty ||
        user.phone.isEmpty ||
        user.password.isEmpty) {
      error = "Vui lòng điền đầy đủ thông tin!";
    } else if (!Utils.isValidEmail(user.email)) {
      error = "Email không hợp lệ!";
    } else if (!Utils.isPhoneNumber(user.phone)) {
      error = "Số điện thoại phải là 10 số!";
    } else if (user.password.length < 6) {
      error = "Mật khẩu ít nhất 6 ký tự!";
    } else if (await Utils.isExistPhoneNumber(user.phone)) {
      error = "Số điện thoại đã được sử dụng!";
    }

    if (error != "") {
      return error;
    } else {
      try {
        UserModel? userModel = await getUserByUsername(user.email);
        if (userModel != null) {
          if (userModel.provider == "password") {
            return "Email đã được sử dụng!";
          } else {
            return "Email đã được sử dụng và bạn đã đăng nhập bằng Google!";
          }
        } else {
          UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: user.email, password: user.password);

          if (userCredential.user != null) {
            await firebaseFirestore
                .collection("Users")
                .doc(user.email)
                .set(user.toJson());

            return null;
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-in-use") {
          return "Email đã được sử dụng!";
        }
      } catch (e) {
        return e.toString();
      }
    }
    return null;
  }

  Future<bool> updatePhone(String phone) async {
    final email = firebaseUser.value?.providerData[0].email;

    if (email == null) {
      return false;
    } else {
      try {
        await firebaseFirestore
            .collection("Users")
            .doc(email)
            .update({"phone": phone});
        return true;
      } catch (e) {
        return false;
      }
    }
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      String? error = "";

      if (user.name.isEmpty) {
        error = "Vui lòng nhập tên!";
      } else if (user.phone.isEmpty) {
        error = "Vui lòng nhập số điện thoại!";
      } else if (!Utils.isPhoneNumber(user.phone)) {
        error = "Số điện thoại phải 10 ký tự!";
      } else if (user.address!.isEmpty) {
        error = "Vui lòng nhập địa chỉ!";
      }

      if (user.phone.isNotEmpty) {
        final UserModel? userModel = await getUserByUsername(user.email);
        if (await Utils.isExistPhoneNumber(user.phone) &&
            userModel?.phone != user.phone) {
          error = "Số điện thoại đã được sử dụng!";
        }
      }

      if (error != "") {
        Utils.showSnackBar(error, Colors.red, Icons.error);
        return false;
      } else {
        UserModel? userModel = await getUserByUsername(user.email);

        if (userModel != null) {
          await firebaseFirestore
              .collection("Users")
              .doc(user.email)
              .update(user.toJson());

          // if (userModel.phone != user.phone) {
          //   await firebaseFirestore
          //       .collection("Users")
          //       .doc(user.email)
          //       .update({"phone": userModel.phone});
          //   Get.to(() => OtpScreen(phone: user.phone));
          // } else {
          //   return true;
          // }
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePaper(Uint8List? imageIdCardFront,
      Uint8List? imageIdCardBack,
      Uint8List? imageLicenseFront,
      Uint8List? imageLicenseBack) async {
    final email = firebaseUser.value?.providerData[0].email;
    if (email == null) {
      return false;
    } else {
      try {
        UserModel? userModel = await getUserByUsername(email);
        if (userModel?.imageIdCardFront == null &&
            userModel?.imageIdCardBack == null &&
            userModel?.imageLicenseFront == null &&
            userModel?.imageLicenseBack == null) {
          await Utils.uploadImage(
              imageIdCardFront, "users", email, "imageIdCardFront", "Users");
          await Utils.uploadImage(
              imageIdCardBack, "users", email, "imageIdCardBack", "Users");
          await Utils.uploadImage(
              imageLicenseFront, "users", email, "imageLicenseFront", "Users");
          await Utils.uploadImage(
              imageLicenseBack, "users", email, "imageLicenseBack", "Users");
        } else {
          if (imageIdCardFront != null) {
            await Utils.uploadImage(
                imageIdCardFront, "users", email, "imageIdCardFront", "Users");
            await Utils.deleteImageIfExists(userModel?.imageIdCardFront ?? "");
          }
          if (imageIdCardBack != null) {
            await Utils.uploadImage(
                imageIdCardBack, "users", email, "imageIdCardBack", "Users");
            await Utils.deleteImageIfExists(userModel?.imageIdCardBack ?? "");
          }
          if (imageLicenseFront != null) {
            await Utils.uploadImage(imageLicenseFront, "users", email,
                "imageLicenseFront", "Users");
            await Utils.deleteImageIfExists(userModel?.imageLicenseFront ?? "");
          }
          if (imageLicenseBack != null) {
            await Utils.uploadImage(
                imageLicenseBack, "users", email, "imageLicenseBack", "Users");
            await Utils.deleteImageIfExists(userModel?.imageLicenseBack ?? "");
          }

          await firebaseFirestore
              .collection("Users")
              .doc(email)
              .update({"message": "", "isVerified": false});

          return true;
        }
      } catch (e) {
        return true;
      }

      return true;
    }
  }

  Future<String?> changePassword(String password,
      String confirmPassword) async {
    final email = firebaseUser.value?.providerData[0].email;

    if (email == null) {
      return "Có lỗi xảy ra. Vui lòng thử lại sau!";
    } else if (password.isEmpty || confirmPassword.isEmpty) {
      return "Vui lòng điền đầy đủ thông tin!";
    } else if (password.length < 6 || confirmPassword.length < 6) {
      return "Mật ít nhất 6 ký tự!";
    } else if (password != confirmPassword) {
      return "Mật khẩu không trùng khớp!";
    } else {
      try {
        UserModel? userModel = await getUserByUsername(email);
        if (userModel?.provider == "password") {
          final User? user = firebaseAuth.currentUser;
          if (user != null) {
            await user.updatePassword(password);
          }
        } else {
          await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password);
          final snapshot = await firebaseFirestore
              .collection("Users")
              .where("email", isEqualTo: email)
              .get();

          if (snapshot.docs.isNotEmpty) {
            final userDoc = snapshot.docs.first;
            await userDoc.reference.update({"provider": "password"});
          }
        }
        return null;
      } catch (e) {
        return e.toString();
      }
    }
  }

  Future<void> addFavorite(String id) async {
    final email = firebaseUser.value?.providerData[0].email;
    if (email == null) {
      Utils.showSnackBar(
        "Có lỗi xảy ra vui lòng thử lại sau.",
        Colors.red,
        Icons.error,
      );
    } else {
      try {
        final listFavorite =
        await firebaseFirestore.collection("Favorites").doc(email).get();

        if (listFavorite.data() == null) {
          await firebaseFirestore.collection("Favorites").doc(email).set({
            "listFavorite": [id]
          });
        } else {
          if (listFavorite.data()!["listFavorite"].contains(id)) {
            await firebaseFirestore.collection("Favorites").doc(email).update({
              "listFavorite": FieldValue.arrayRemove([id])
            });

            Get.snackbar("Thông báo", "Đã xóa khỏi yêu thích");
          } else {
            await firebaseFirestore.collection("Favorites").doc(email).update({
              "listFavorite": FieldValue.arrayUnion([id])
            });

            Get.snackbar("Thông báo", "Đã thêm vào yêu thích");
          }
        }
      } catch (e) {
        return;
      }
    }
  }

  Future<List<CarModel>?> getFavorite() async {
    final email = firebaseUser.value?.providerData[0].email;

    if (email == null) {
      Utils.showSnackBar(
        "Có lỗi xảy ra vui lòng thử lại sau.",
        Colors.red,
        Icons.error,
      );
    } else {
      try {
        final listFavorite =
        await firebaseFirestore.collection("Favorites").doc(email).get();

        if (!listFavorite.exists) {
          return [];
        }

        List<dynamic> favoriteIds = listFavorite.data()?["listFavorite"] ?? [];

        List<CarModel> carList = [];
        for (var id in favoriteIds) {
          final carDoc =
          await FirebaseFirestore.instance.collection("Cars").doc(id).get();
          if (carDoc.exists) {
            carList.add(CarModel.fromSnapshot(
              carDoc,
              isFavorite: true,
            ));
          }
        }

        return carList;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<List<CarModel>?> getCarRentalScreen() async {
    final email = firebaseUser.value?.providerData[0].email;

    if (email == null) {
      Utils.showSnackBar(
        "Có lỗi xảy ra vui lòng thử lại sau.",
        Colors.red,
        Icons.error,
      );
    } else {
      try {
        QuerySnapshot querySnapshot = await firebaseFirestore
            .collection("Cars")
            .where("email", isEqualTo: email)
            .get();

        List<CarModel> carList = querySnapshot.docs.map((doc) {
          return CarModel.fromSnapshot(
              doc as DocumentSnapshot<Map<String, dynamic>>);
        }).toList();

        return carList;
      } catch (e) {
        return null;
      }
    }

    return null;
  }

  Future<List<RentalCarModel>?> getRequestCarRentalScreen() async {
    final email = firebaseUser.value?.providerData[0].email;
    if (email == null) {
      Utils.showSnackBar(
        "Có lỗi xảy ra vui lòng thử lại sau.",
        Colors.red,
        Icons.error,
      );
    } else {
      try {
        QuerySnapshot querySnapshot = await firebaseFirestore
            .collection("Rentals")
            .where("idOwner", isEqualTo: email)
            .where("status", isEqualTo: "waiting")
            .get();

        List<RentalModel> rentalList = querySnapshot.docs.map((doc) {
          return RentalModel.fromSnapshot(
              doc as DocumentSnapshot<Map<String, dynamic>>);
        }).toList();

        List<RentalCarModel> rentalCarModelList = [];
        for (var rental in rentalList) {
          if (DateTime.parse(rental.fromDate).isAfter(DateTime.now())) {
            final carDoc = await FirebaseFirestore.instance
                .collection("Cars")
                .doc(rental.idCar)
                .get();

            if (carDoc.exists) {
              rentalCarModelList.add(
                RentalCarModel(
                  rentalModel: rental,
                  carModel: CarModel.fromSnapshot(carDoc),
                ),
              );
            }
          }
        }

        return rentalCarModelList;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<List<RentalCarModel>?> getHistory() async {
    final email = firebaseUser.value?.providerData[0].email;

    if (email == null) {
      Utils.showSnackBar(
        "Có lỗi xảy ra vui lòng thử lại sau.",
        Colors.red,
        Icons.error,
      );
    } else {
      try {
        QuerySnapshot querySnapshot = await firebaseFirestore
            .collection("Rentals")
            .where("email", isEqualTo: email)
            .orderBy("status", descending: true)
            .get();

        List<RentalModel> rentalList = querySnapshot.docs.map((doc) {
          return RentalModel.fromSnapshot(
              doc as DocumentSnapshot<Map<String, dynamic>>);
        }).toList();

        List<RentalCarModel> rentalCarModelList = [];
        for (var rental in rentalList) {
          final carDoc = await FirebaseFirestore.instance
              .collection("Cars")
              .doc(rental.idCar)
              .get();

          if (carDoc.exists) {
            rentalCarModelList.add(
              RentalCarModel(
                rentalModel: rental,
                carModel: CarModel.fromSnapshot(carDoc),
              ),
            );
          }
        }

        return rentalCarModelList;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<List<RentalCarModel>?> getHistoryRental() async {
    final email = firebaseUser.value?.providerData[0].email;

    if (email == null) {
      Utils.showSnackBar(
        "Có lỗi xảy ra vui lòng thử lại sau.",
        Colors.red,
        Icons.error,
      );
    } else {
      try {
        QuerySnapshot querySnapshot = await firebaseFirestore
            .collection("Rentals")
            .where("idOwner", isEqualTo: email)
            .orderBy("status", descending: true)
            .get();

        List<RentalModel> rentalList = querySnapshot.docs.map((doc) {
          return RentalModel.fromSnapshot(
              doc as DocumentSnapshot<Map<String, dynamic>>);
        }).toList();

        List<RentalCarModel> rentalCarModelList = [];
        for (var rental in rentalList) {
          final carDoc = await FirebaseFirestore.instance
              .collection("Cars")
              .doc(rental.idCar)
              .get();

          if (carDoc.exists) {
            rentalCarModelList.add(
              RentalCarModel(
                rentalModel: rental,
                carModel: CarModel.fromSnapshot(carDoc),
              ),
            );
          }
        }

        return rentalCarModelList;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<bool> sendMessage(String message, String emailReceiver) async {
    final email = firebaseUser.value?.providerData[0].email;

    if (email == null) {
      return false;
    } else {
      try {
        final querySnapshot = await firebaseFirestore
            .collection("ChatRooms")
            .where("participants",
            arrayContainsAny: [emailReceiver, email]).get();

        if (querySnapshot.docs.isNotEmpty) {
          final chatRoomId = querySnapshot.docs.first.id;

          await firebaseFirestore
              .collection("ChatRooms")
              .doc(chatRoomId)
              .collection("Messages")
              .add({
            "message": message,
            "emailSender": email,
            "emailReceiver": emailReceiver,
            "time": DateTime.now(),
          });

          await firebaseFirestore
              .collection("ChatRooms")
              .doc(chatRoomId)
              .update({
            "lastMessage": message,
          });
        } else {
          final newChatRoomRef =
          firebaseFirestore.collection("ChatRooms").doc();
          await newChatRoomRef.set({
            "participants": [emailReceiver, email],
          });
          await newChatRoomRef.collection("Messages").add({
            "message": message,
            "emailSender": email,
            "emailReceiver": emailReceiver,
            "time": DateTime.now(),
          });

          await newChatRoomRef.update({
            "lastMessage": message,
          });
        }

        return true;
      } catch (e) {
        return false;
      }
    }
  }

  Future<ChatModel?> getChatRoom(String emailReceiver) async {
    final email = FirebaseAuth.instance.currentUser?.email;

    if (email == null) {
      return null;
    } else {
      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection("ChatRooms")
            .where("participants",
            arrayContainsAny: [emailReceiver, email]).get();

        if (querySnapshot.docs.isNotEmpty) {
          final chatRoomId = querySnapshot.docs.first.id;

          final chatRoomDoc = await FirebaseFirestore.instance
              .collection("ChatRooms")
              .doc(chatRoomId)
              .get();

          UserModel? user = await getUserByUsername(emailReceiver);

          if (user != null) {
            return ChatModel.fromFirestore(chatRoomDoc, user);
          }
        }

        return null;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }
}
