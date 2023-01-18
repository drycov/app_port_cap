// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:app_port_cap/app/auxiliary/auxiliary.dart';
import 'package:app_port_cap/app/models/index.dart';
import 'package:app_port_cap/app/resources/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/index.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  final datastore = GetStorage();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User> get getUser async => _auth.currentUser!;
  Stream<User?> get user => _auth.authStateChanges();
  final RxBool admin = false.obs;

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
      await isAdmin();
    }

    if (_firebaseUser == null) {
      Get.toNamed("/auth");
    } else {
      Get.toNamed('/home');
    }
  }

  isAdmin() async {
    await getUser.then((user) async {
      DocumentSnapshot adminRef =
          await _db.collection('admin').doc(user.uid).get();
      if (adminRef.exists) {
        admin.value = true;
      } else {
        admin.value = false;
      }
      update();
    });
  }

  Stream<UserModel> streamFirestoreUser() {
    // Globals.printMet('streamFirestoreUser()');
    return _db
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  Future<UserModel> getFirestoreUser() {
    return _db.doc('/users/${firebaseUser.value!.uid}').get().then(
        (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // Globals.printMet(credential);
      if (credential.user?.uid != null) {
        await getFirestoreUser();
        Globals.printMet('um', UserModel);
        String? email = credential.user?.email;
        String deviceId = await Globals.getDeviceId();
        var UserAsMap = UserModel(
          uid: credential.user?.uid,
          name: email.toString().replaceAll(RegExp('@(\\w+.+)'), ""),
          cn: 'Оскементранстелеком',
          region: 'Серебрянск (Кумыстау)',
          post: 'Инженер сети',
          firstName: 'Денис',
          lastName: 'Рыков',
          middleName: 'Игорьевич',
          email: email,
          devID: deviceId.toString(),
        ).toJson();
        String jsonString = jsonEncode(UserAsMap);
        if (datastore.read('user') != null) {
          datastore.write('user', jsonString);
        } else {
          datastore.write('user', jsonString);
        }
        datastore.write('isAuthenticated', true);
        setupToken();

        emailController.clear();
        passwordController.clear();
        onReady();
        // Get.toNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toastmessage('msg.error.text.nouser'.tr, TTCCorpColors.Red);
        print('No user found for that email.');
      } else if (e.code == 'invalid-email') {
        toastmessage('msg.error.text.nouser'.tr, TTCCorpColors.Red);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        toastmessage('msg.error.text.wrongpassword'.tr, TTCCorpColors.Red);
        print('Wrong password provided for that user.');
      } else if (e.code == 'network-request-failed') {
        toastmessage('msg.error.text.noInternet'.tr, TTCCorpColors.Red);
        print('No internet connection.');
      }
    }
  }

  // Sign out
  Future<void> signOut() {
    emailController.clear();
    passwordController.clear();
    datastore.remove('user');
    datastore.write('isAuthenticated', false);
    Get.offNamed('/');
    return _auth.signOut();
  }

  Future<void> setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();
    await Globals().saveTokenToDatabase(token!);
    // Save the initial token to the database
    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh
        .listen(Globals().saveTokenToDatabase);
  }
}
