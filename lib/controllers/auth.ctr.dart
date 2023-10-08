import 'dart:io';

import 'package:demo_app/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCtr extends GetxService {
  final auth = FirebaseAuth.instance;
  final docUser = FirebaseFirestore.instance.collection("users");
  final storageProfile = FirebaseStorage.instance.ref('profiles');

  Future<void> login({
    required String email,
    required String password,
  }) async {
    SmartDialog.showLoading(msg: "Loading...");
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      prefs.setString("accessToken", result.credential?.accessToken ?? "");
      prefs.setString("uid", "");
    } catch (e) {
      logger.e(e);
    }
    SmartDialog.dismiss();
  }

  Future<void> logout() async {
    SmartDialog.showLoading(msg: "Loading...");
    try {
      await auth.signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("accessToken", "");
      prefs.setString("uid", "");
    } catch (e) {
      logger.e(e);
    }
    SmartDialog.dismiss();
  }

  Future<void> registor({
    required String email,
    required String password,
    required PlatformFile platformFile,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final path = platformFile.name;
      final file = File(platformFile.path!);

      final ref = storageProfile.child(path);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => null);
      final urlDownload = await snapshot.ref.getDownloadURL();
      logger.i(urlDownload);

      // docUser.doc(userModel.value.id).update({"picture": urlDownload});
      auth.currentUser?.updatePhotoURL(urlDownload);
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
