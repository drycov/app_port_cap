// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:app_port_cap/app/auxiliary/auxiliary.dart';
import 'package:app_port_cap/app/models/index.dart';
import 'package:app_port_cap/app/queryes/query.dart';
import 'package:app_port_cap/app/resources/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/index.dart';

class AuthController extends GetxController {
  final datastore = GetStorage();

  static AuthController to = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User> get getUser async => _auth.currentUser!;
  Stream<User?> get user => _auth.authStateChanges();
  // final RxBool admin = false.obs;

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

    if (_firebaseUser == null && datastore.read('user') == null) {
      Get.offAllNamed("/auth");
    } else {
      setupToken();
      Get.offAllNamed('/home');
    }
  }

  isAdmin() async {
    await getUser.then((user) async {
      CollectionReference adminCollRef = _db.collection('admin');
      DocumentSnapshot adminRef = await adminCollRef.doc(user.uid).get();
      if (adminRef.exists) {
        // admin.value = true;
        datastore.write('admin', true);
      } else {
        adminCollRef
            .doc(user.uid)
            .set({
              'admin': false,
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
        // admin.value = false;
        datastore.write('admin', false);
      }
      // update();
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
    showLoadingIndicator();
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // Globals.printMet(credential);
      if (credential.user?.uid != null) {
        UserModel uModel = await getFirestoreUser();
        Globals.printMet('um', uModel.toJson());
        String? email = credential.user?.email;
        String deviceId = await Globals.getDeviceId();
        CNModel cnModel = await FRBQuery().getUserCN(uModel.cn.toString());
        RegionModel rModel =
            await FRBQuery().getUserRegion(uModel.region.toString());
        CompanyPostsModel cpModel =
            await FRBQuery().getUserCP(uModel.company_posts.toString());
        CompanyDeportamentsModel cndpModel =
            await FRBQuery().getUserCnD(cpModel.cn_index.toString());

        datastore.write(
            'user',
            jsonEncode(UserModel(
              uid: credential.user?.uid,
              name: email.toString().replaceAll(RegExp('@(\\w+.+)'), ""),
              email: uModel.email.toString(),
              cn: cnModel.name.toString(),
              cndp: cndpModel.name.toString(),
              region: rModel.name.toString(),
              firstName: uModel.firstName.toString(),
              lastName: uModel.lastName.toString(),
              middleName: uModel.middleName.toString(),
              company_posts: cpModel.name.toString(),
              devID: deviceId.toString(),
            ).toJson()));
        datastore.write('isAuthenticated', true);
        emailController.clear();
        passwordController.clear();
        hideLoadingIndicator();
        onReady();
      }
    } on FirebaseAuthException catch (e) {
      hideLoadingIndicator();
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
    final datastore = GetStorage();
    emailController.clear();
    passwordController.clear();
    datastore.remove('user');
    datastore.write('admin', false);
    datastore.write('isAuthenticated', false);
    Get.offAllNamed('/auth');
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
