// ignore_for_file: avoid_print

import 'dart:io';

import 'package:app_port_cap/app/models/index.dart';
import 'package:app_port_cap/app/resources/resources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:android_id/android_id.dart';

import '../system/index.dart';

class Globals {
  static const String defaultLanguage = 'ru';
  static const _androidIdPlugin = AndroidId();

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(
        langCode: "ru",
        name: "🇷🇺 Русский",
        locale: const Locale('ru'),
        flag: Flag(Flags.russia)), //Russian
    MenuOptionsModel(
        langCode: "kz",
        name: "Казақ",
        locale: const Locale('kz'),
        flag: Flag(Flags.kazakhstan)), //German
    MenuOptionsModel(
        langCode: "en",
        name: "English",
        locale: const Locale('en'),
        flag: Flag(Flags.united_states_of_america)), //English
  ];

  static final List locale = [
    {
      'name': '🇺🇸 English',
      'locale': const Locale('en'),
      'langCode': 'en',
      'flag': Flag(Flags.united_states_of_america)
    },
    {
      'name': '🇷🇺 Русский',
      'locale': const Locale('ru'),
      'langCode': 'ru',
      'flag': Flag(Flags.russia)
    },
    {
      'name': '🇰🇿 Қазақ',
      'locale': const Locale('kz'),
      'langCode': 'kz',
      'flag': Flag(Flags.kazakhstan)
    },
  ];

  static Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    late String deviceId;

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor!;
    } else if (Platform.isAndroid) {
      deviceId = await _androidIdPlugin.getId() ?? 'Unknown ID';
    } else {
      deviceId = 'null';
    }
    return deviceId;
  }

  static void printMet(String? title, dynamic msg) {
    print('$title: $msg');
  }

  Future<void> saveTokenToDatabase(String token) async {
    User? user = FirebaseAuth.instance.currentUser!;
    String deviceId = await Globals.getDeviceId();
    var UserAsMap = UserModel(
      uid: user.uid,
      name: user.email.toString().replaceAll(RegExp('@(\\w+.+)'), ""),
      email: user.email.toString(),
      cn: 'ttc-0',
      cndp: 'ca',
      region: 'region-0-0',
      firstName: 'NaN',
      lastName: 'NaN',
      middleName: 'NaN',
      company_posts: 'ca_1',
      devID: deviceId,
    ).toJson();
    // Assume user is logged in for this example
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    CollectionReference usersCollRef = _db.collection('users');
    DocumentSnapshot usersRef = await usersCollRef.doc(userId).get();
    if (usersRef.exists) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'tokens': FieldValue.arrayUnion([token]),
      });
    } else {
      usersCollRef.doc(userId).set({
        'tokens': FieldValue.arrayUnion([token]),
      }).catchError((error) => print("Failed to add user: $error"));
      usersCollRef
          .doc(userId)
          .update(UserAsMap)
          .catchError((error) => print("Failed to add user: $error"));
    }
  }

  static void buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return GetBuilder<LanguageController>(
            builder: (controller) => AlertDialog(
              backgroundColor: TTCCorpColors.White,
              title: Text(
                'lang.choseLangTitle'.tr,
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Text(
                                LocaleString.locale[index]['name'],
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          onTap: () async {
                            // _lang = Globals.locale[index]['langCode'];
                            // datastore.write("locale", _lang);

                            // updateLanguage(Globals.locale[index]['locale']);

                            await controller.updateLanguage(
                                LocaleString.locale[index]['langCode']!);
                            Get.forceAppUpdate();
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.blue,
                      );
                    },
                    itemCount: Globals.locale.length),
              ),
            ),
          );
        });
  }
}

class IpUtil {
  static bool verifyIp(final String ip) {
    // check correct structure
    final ipSplit = ip.split('.');
    if (ipSplit.length != 4) return false;

    // check four blocks are able to be converted to int
    final ipBlocks = <int>[];

    for (int i = 0; i < 4; i++) {
      // check if split string can be converted to int
      try {
        ipBlocks[i] = int.parse(ipSplit[i]);

        // check if block is between 0 and 255
        if (ipBlocks[i] < 0 || ipBlocks[i] > 255) return false;
      } on FormatException {
        return false;
      }
    }
    return true;
  }
}
