// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:app_port_cap/app/auxiliary/auxiliary.dart';
import 'package:app_port_cap/app/models/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/index.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  final datastore = GetStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // Globals.printMet(credential);
      if (credential.user?.uid != null) {
        String? email = credential.user?.email;
        var UserAsMap = UserModel(
                uid: credential.user?.uid,
                name: email.toString().replaceAll(RegExp('@(\\w+.+)'), ""),
                cn: 'Oskementranstelecom',
                post: 'Network Engeneer',
                firstName: 'Denis',
                lastName: 'Rykov',
                middleName: ' ',
                email: email,
                fileName: ' ',
                devID: ' ',
                photoUrl: ' ')
            .toJson();
        String jsonString = jsonEncode(UserAsMap);
        if (datastore.read('user') != null) {
          datastore.write('user', jsonString);
        } else {
          datastore.write('user', jsonString);
        }
        Globals.printMet(datastore.read('user'));
        emailController.clear();
        passwordController.clear();
        Get.toNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      Globals.printMet(e.code);
      if (e.code == 'user-not-found') {
        fireToast('validator.email'.tr);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        fireToast('validator.password'.tr);
        print('Wrong password provided for that user.');
      } else if (e.code == 'network-request-failed') {
        fireToast('validator.password'.tr);
        print('No internet connection.');
      }
    }
  }

  // Sign out
  Future<void> signOut() {
    emailController.clear();
    passwordController.clear();
    datastore.remove('user');
    Get.offNamed('/');
    return _auth.signOut();
  }
}
