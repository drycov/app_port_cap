import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';

class SplashUI extends StatefulWidget {
  const SplashUI({Key? key}) : super(key: key);

  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  late FlameSplashController controller;

  @override
  void initState() {
    super.initState();
    controller = FlameSplashController(
        fadeInDuration: const Duration(seconds: 1),
        fadeOutDuration: const Duration(milliseconds: 250),
        waitDuration: const Duration(seconds: 2),
        autoStart: true);
  }

  @override
  void dispose() {
    controller.dispose(); // dispose it when necessary
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
    // AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await this.isLoggedIn();
    if (isLoggedIn) {
      Get.offNamed('/home');
      return;
    }
    Get.offNamed('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        controller: controller,
        onFinish: (context) => {
          // Future.delayed(const Duration(seconds: 5), () {
          checkSignedIn()
          // }),
        },
        theme: FlameSplashTheme.dark,
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) => Scaffold(
  //       backgroundColor: GlobalColors.layerOneBg,
  //       body: Container(
  //         decoration: const BoxDecoration(
  //           gradient: LinearGradient(
  //             begin: Alignment.topRight,
  //             end: Alignment.bottomLeft,
  //             stops: [
  //               0.1,
  //               0.3,
  //               0.5,
  //               0.7,
  //               0.8,
  //             ],
  //             colors: [
  //               TTCCorpColors.Salem,
  //               TTCCorpColors.ForestGreen,
  //               TTCCorpColors.Apple,
  //               TTCCorpColors.Lima,
  //               TTCCorpColors.Sushi,
  //             ],
  //           ),
  //         ),
  //         child: const Align(
  //             alignment: Alignment.center,
  //             child: CircularProgressIndicator(
  //               color: TTCCorpColors.Salem,
  //               strokeWidth: 8,
  //               backgroundColor: TTCCorpColors.MossGreen,
  //             )),
  //       ),
  //     );
}
