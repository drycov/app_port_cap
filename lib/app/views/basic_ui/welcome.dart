import 'dart:async';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashUI extends StatefulWidget {
  const SplashUI({Key? key}) : super(key: key);

  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  // late FlameSplashController controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () => checkSignedIn());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> isLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    final datastore = GetStorage();
    if (user != null && datastore.read('user')?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  void checkSignedIn() async {
    bool isLoggedIn = await this.isLoggedIn();

    if (isLoggedIn) {
      Get.offAllNamed('/home');
      return;
    }
    Get.offAllNamed('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: ConnectivityWidgetWrapper(
        disableInteraction: true,
        height: 80,
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
