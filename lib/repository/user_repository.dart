import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/repository/car_repository.dart';
import 'package:vehicle_rental_app/screens/approve_user_paper_screen.dart';
import 'package:vehicle_rental_app/screens/auth/login_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const LayoutScreen());
  }

  // done
  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  // done
  bool isPhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^(\d{10}|)$');
    return regex.hasMatch(phoneNumber);
  }

  // done
  Future<bool> isExistPhoneNumber(String phoneNumber) async {
    final isExist = await firebaseFirestore
        .collection("Users")
        .where("phone", isEqualTo: phoneNumber)
        .get();
    return isExist.docs.isNotEmpty;
  }

  // done
  Future<void> loginUser(String username, String password) async {
    try {
      String error = "";
      if (username.isEmpty || password.isEmpty) {
        error = "Vui lòng điền đầy đủ thông tin!";
      } else if (password.length < 6) {
        error = "Mật khẩu ít nhất 6 ký tự!";
      }

      if (error != "") {
        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: Text(
            error,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 10),
          icon: const Icon(Icons.error, color: Colors.white),
          onTap: (_) {
            Get.closeCurrentSnackbar();
          },
        ));
      } else if (isPhoneNumber(username)) {
        UserModel? user = await getUserDetails(username);
        if (user == null) {
          Get.closeCurrentSnackbar();
          Get.showSnackbar(GetSnackBar(
            messageText: const Text(
              "Tài khoản hoặc mật khẩu không chính xác!",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 10),
            icon: const Icon(Icons.error, color: Colors.white),
            onTap: (_) {
              Get.closeCurrentSnackbar();
            },
          ));
        } else {
          await firebaseAuth.signInWithEmailAndPassword(
              email: user.email, password: password);
        }
      } else {
        await firebaseAuth.signInWithEmailAndPassword(
            email: username, password: password);
      }
      Get.offAll(() => const LayoutScreen());
    } on FirebaseAuthException catch (e) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: const Text(
          "Tài khoản hoặc mật khẩu không chính xác!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    } catch (e) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    }
  }

  // done
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

        UserModel? user = await getUserDetails(googleSignInAccount.email);

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
        Get.offAll(() => const LayoutScreen());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message.toString());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // done
  Future<void> logoutUser() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    Get.offAll(() => const LoginScreen());
  }

  // done
  Future<void> createUser(UserModel user) async {
    String error = "";
    if (user.name.isEmpty ||
        user.email.isEmpty ||
        user.phone.isEmpty ||
        user.password.isEmpty) {
      error = "Vui lòng điền đầy đủ thông tin!";
    } else if (!isValidEmail(user.email)) {
      error = "Email không hợp lệ!";
    } else if (!isPhoneNumber(user.phone)) {
      error = "Số điện thoại phải là 10 số!";
    } else if (user.password.length < 6) {
      error = "Mật khẩu ít nhất 6 ký tự!";
    } else if (await isExistPhoneNumber(user.phone)) {
      error = "Số điện thoại đã được sử dụng!";
    }

    if (error != "") {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: Text(
          error,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    } else {
      try {
        UserModel? userModel = await getUserDetails(user.email);
        if (userModel != null) {
          if (userModel.provider == "password") {
            Get.closeCurrentSnackbar();
            Get.showSnackbar(GetSnackBar(
              messageText: const Text(
                "Email đã được sử dụng!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 10),
              icon: const Icon(Icons.error, color: Colors.white),
              onTap: (_) {
                Get.closeCurrentSnackbar();
              },
            ));
          } else {
            Get.closeCurrentSnackbar();
            Get.showSnackbar(GetSnackBar(
              messageText: const Text(
                "Email đã được sử dụng và bạn đã đăng nhập bằng Google!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 10),
              icon: const Icon(Icons.error, color: Colors.white),
              onTap: (_) {
                Get.closeCurrentSnackbar();
              },
            ));
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

            Get.snackbar(
              "Chúc mừng",
              "Bạn đã tạo tài khoản thành công!",
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green,
              snackPosition: SnackPosition.TOP,
              icon: const Icon(Icons.check, color: Colors.green),
              duration: const Duration(seconds: 3),
            );
            Get.offAll(() => const LayoutScreen());
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-in-use") {
          Get.closeCurrentSnackbar();
          Get.showSnackbar(GetSnackBar(
            messageText: const Text(
              "Email đã được sử dụng!",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 10),
            icon: const Icon(Icons.error, color: Colors.white),
            onTap: (_) {
              Get.closeCurrentSnackbar();
            },
          ));
        }
      } catch (e) {
        Get.snackbar(
          "Lỗi",
          e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    }
  }

  // done
  Future<UserModel?> getUserDetails(String username) async {
    if (username.isEmpty) return null;

    try {
      if (isPhoneNumber(username)) {
        final snapshot = await firebaseFirestore
            .collection("Users")
            .where("phone", isEqualTo: username)
            .get();
        final userData =
            snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
        return userData;
      } else {
        final snapshot = await firebaseFirestore
            .collection("Users")
            .where("email", isEqualTo: username)
            .get();
        final userData =
            snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
        return userData;
      }
    } catch (e) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: const Text(
          "Có lỗi xảy ra. Vui lòng thử lại sau!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
      return null;
    }
  }

  Future<void> changePassword(String password, String confirmPassword) async {
    final email = firebaseUser.value?.providerData[0].email;

    if (email == null) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: const Text(
          "Có lỗi xảy ra. Vui lòng thử lại sau!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    } else if (password != confirmPassword) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: const Text(
          "Mật khẩu không trùng khớp!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    } else {
      try {
        UserModel? userModel = await getUserDetails(email);
        if (userModel?.provider == "password") {
          final User? user = FirebaseAuth.instance.currentUser;
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

        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: Text(
            userModel?.provider == "password"
                ? "Mật khẩu đã được thay đổi thành công!"
                : "Tạo mật khẩu mới thành công!",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 10),
          icon: const Icon(Icons.check, color: Colors.white),
          onTap: (_) {
            Get.closeCurrentSnackbar();
          },
        ));
      } on FirebaseAuthException catch (e) {
        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: Text(
            e.message ?? "Có lỗi xảy ra. Vui lòng thử lại sau!",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 10),
          icon: const Icon(Icons.error, color: Colors.white),
          onTap: (_) {
            Get.closeCurrentSnackbar();
          },
        ));
      }
    }
  }

// Future<List<UserModel>> getAllUser() async {
//   final snapshot = await firebaseFirestore.collection("Users").get();
//   final userData =
//       snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
//   return userData;
// }

  Future<void> updateUser(UserModel user) async {
    try {
      String? error = "";

      if (user.name.isEmpty) {
        error = "Vui lòng nhập tên!";
      } else if (user.phone.isEmpty) {
        error = "Vui lòng nh1ập số điện thoại!";
      } else if (!isPhoneNumber(user.phone)) {
        error = "Số điện thoại phải 10 ký tự!";
      } else if (user.addressRoad!.isEmpty) {
        error = "Vui lòng nhập tên đường!";
      } else if (user.addressDistrict!.isEmpty) {
        error = "Vui lòng nhập quận/huyện!";
      } else if (user.addressCity!.isEmpty) {
        error = "Vui lòng nhập tỉnh/thành phố!";
      }

      if (user.phone.isNotEmpty) {
        final UserModel? userModel = await getUserDetails(user.email);
        if (await isExistPhoneNumber(user.phone) &&
            userModel?.phone != user.phone) {
          error = "Số điện thoại đã được sử dụng!";
        }
      }

      if (error != "") {
        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: Text(
            error,
            style: const TextStyle(
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
      } else {
        await firebaseFirestore
            .collection("Users")
            .doc(user.email)
            .update(user.toJson());

        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: const Text(
            "Cập nhật thông tin thành công!",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 5),
          icon: const Icon(Icons.check, color: Colors.white),
          onTap: (_) {
            Get.closeCurrentSnackbar();
          },
        ));
      }
    } on FirebaseAuthException catch (e) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: Text(
          e.message ?? "Có lỗi xảy ra. Vui này thử được sau!",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    } catch (e) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    }
  }

  Future<void> updateUserWithImage(
      UserModel user, Uint8List imageAvatar) async {
    try {
      String? error = "";

      if (user.name.isEmpty) {
        error = "Vui lòng nhập tên!";
      } else if (user.phone.isEmpty) {
        error = "Vui lòng nh1ập số điện thoại!";
      } else if (!isPhoneNumber(user.phone)) {
        error = "Số điện thoại phải 10 ký tự!";
      } else if (user.addressRoad!.isEmpty) {
        error = "Vui lòng nhập tên đường!";
      } else if (user.addressDistrict!.isEmpty) {
        error = "Vui lòng nhập quận/huyện!";
      } else if (user.addressCity!.isEmpty) {
        error = "Vui lòng nhập tỉnh/thành phố!";
      }

      if (user.phone.isNotEmpty) {
        final UserModel? userModel = await getUserDetails(user.email);
        if (await isExistPhoneNumber(user.phone) &&
            userModel?.phone != user.phone) {
          error = "Số điện thoại đã được sử dụng!";
        }
      }

      if (error != "") {
        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: Text(
            error,
            style: const TextStyle(
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
      } else {
        await firebaseFirestore
            .collection("Users")
            .doc(user.email)
            .update(user.toJson());

        await Utils.deleteImageIfExists(user.imageAvatar!);
        await Utils.uploadImage(
            imageAvatar, 'users', user.email, 'imageAvatar', "Users");

        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: const Text(
            "Cập nhật thông tin thành công!",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 5),
          icon: const Icon(Icons.check, color: Colors.white),
          onTap: (_) {
            Get.closeCurrentSnackbar();
          },
        ));
      }
    } on FirebaseAuthException catch (e) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: Text(
          e.message ?? "Có lỗi xảy ra. Vui này thử lại sau!",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    } catch (e) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    }
  }

  Future<void> updatePaper(
      Uint8List? imageIdCardFront,
      Uint8List? imageIdCardBack,
      Uint8List? imageLicenseFront,
      Uint8List? imageLicenseBack) async {
    final email = firebaseUser.value?.providerData[0].email;
    if (email == null) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: const Text(
          "Có lỗi xảy ra. Vui lòng thử lại sau!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    } else {
      try {
        UserModel? userModel = await getUserDetails(email);
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

          Get.closeCurrentSnackbar();
          Get.showSnackbar(GetSnackBar(
            messageText: const Text(
              "Cập nhật giấy tờ thành công!",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
            icon: const Icon(Icons.check, color: Colors.white),
            onTap: (_) {
              Get.closeCurrentSnackbar();
            },
          ));
        }
      } on FirebaseAuthException catch (e) {
        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: Text(
            e.message ?? "Có lỗi xảy ra. Vui bạn thử lại sau!",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 10),
          icon: const Icon(Icons.error, color: Colors.white),
          onTap: (_) {
            Get.closeCurrentSnackbar();
          },
        ));
      } catch (e) {
        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 10),
          icon: const Icon(Icons.error, color: Colors.white),
          onTap: (_) {
            Get.closeCurrentSnackbar();
          },
        ));
      }
    }
  }

  Future<void> forgotPassword(String email) async {
    String error = "";
    if (email.isEmpty) {
      error = "Vui lòng nhập email!";
    } else if (!isValidEmail(email)) {
      error = "Vui lòng nhập đúng định dạng email!";
    }

    if (error != "") {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: Text(
          error,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    } else {
      try {
        UserModel? userModel = await getUserDetails(email);
        if (userModel != null && userModel.provider != "password") {
          Get.closeCurrentSnackbar();
          Get.showSnackbar(GetSnackBar(
            messageText: const Text(
              "Email được đăng ký bằng tài khoản Google, vui lòng đăng nhập với Google!",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error, color: Colors.white),
            onTap: (_) {
              Get.closeCurrentSnackbar();
            },
          ));
        } else {
          await firebaseAuth.sendPasswordResetEmail(email: email);
          Get.closeCurrentSnackbar();
          Get.showSnackbar(GetSnackBar(
            messageText: const Text(
              "Vui lòng kiểm tra email của bạn để đặt lại mật khẩu!",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check, color: Colors.white),
            onTap: (_) {
              Get.closeCurrentSnackbar();
            },
          ));
        }
      } on FirebaseAuthException catch (e) {
        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: const Text(
            "Có lỗi xảy ra. Vui lòng thử lại sau!",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 10),
          icon: const Icon(Icons.error, color: Colors.white),
          onTap: (_) {
            Get.closeCurrentSnackbar();
          },
        ));
      }
    }
  }

  Future<List<CarModel>?> getDataHomeScreen() async {
    final email = firebaseUser.value?.providerData[0].email;

    if (email == null) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: const Text(
          "Có lỗi xảy ra. Vui lòng thử lại sau!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    } else {
      UserModel? userModel = await getUserDetails(email);

      if (userModel == null) {
        return null;
      }
      List<CarModel>? listCar = await CarRepository.instance
          .getCarHomeScreen(userModel.addressDistrict, userModel.addressCity);

      return listCar;
    }
    return null;
  }

  Future<void> addFavorite(String id) async {
    final email = firebaseUser.value?.providerData[0].email;
    if (email == null) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: const Text(
          "Có lỗi xảy ra. Vui lòng thử lại sau!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    } else {
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
        } else {
          await firebaseFirestore.collection("Favorites").doc(email).update({
            "listFavorite": FieldValue.arrayUnion([id])
          });
        }
      }
    }
  }

  Future<List<CarModel>?> getFavorite() async {
    final email = firebaseUser.value?.providerData[0].email;
    if (email == null) {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: const Text(
          "Có lỗi xảy ra. Vui lòng thử lại sau!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
    } else {
      final listFavorite =
          await firebaseFirestore.collection("Favorites").doc(email).get();
      return null;
    }
  }

  Future<List<UserModel>?> getUserApprove() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .where("isAdmin", isEqualTo: false)
        .orderBy("isVerified", descending: false)
        .get();

    List<UserModel> userList = querySnapshot.docs.where((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return data['imageIdCardFront'] != null &&
          data['imageIdCardBack'] != null &&
          data['imageLicenseFront'] != null &&
          data['imageLicenseBack'] != null;
    }).map((doc) {
      return UserModel.fromSnapshot(
          doc as DocumentSnapshot<Map<String, dynamic>>);
    }).toList();

    return userList;
  }

  Future<void> approveUser(String id) async {
    try {
      await firebaseFirestore
          .collection("Users")
          .doc(id)
          .update({"isVerified": true, "message": ""});
      Get.to(() => const ApproveUserPaperScreen());
    } catch (e) {
      return;
    }
  }

  Future<void> cancelUser(String id, String message) async {
    try {
      await firebaseFirestore
          .collection("Users")
          .doc(id)
          .update({"isVerified": false, "message": message});
      Get.to(() => const ApproveUserPaperScreen());
    } catch (e) {
      return;
    }
  }
}
