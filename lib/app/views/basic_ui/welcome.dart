import 'dart:async';

import 'package:app_port_cap/app/resources/app_colors.dart';
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
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      checkSignedIn();
    });
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
    // AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await this.isLoggedIn();
    if (isLoggedIn) {
      Get.offNamed('/home');
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => const HomePage()));
      return;
    }
    Get.offNamed('/auth');
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  // void checkSignedIn() async {
  //   final user = FirebaseAuth.instance.currentUser;

  //   if (user != null) {
  //     Timer(const Duration(seconds: 5), () => Get.toNamed('/home'));
  //   } else {
  //     Timer(const Duration(seconds: 5), () => Get.toNamed('/auth'));
  //   }
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: GlobalColors.layerOneBg,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.3,
                0.5,
                0.7,
                0.8,
              ],
              colors: [
                TTCCorpColors.Salem,
                TTCCorpColors.ForestGreen,
                TTCCorpColors.Apple,
                TTCCorpColors.Lima,
                TTCCorpColors.Sushi,
              ],
            ),
          ),
          child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: TTCCorpColors.Salem,
                strokeWidth: 8,
                backgroundColor: TTCCorpColors.MossGreen,
              )),
        ),
      );
}
