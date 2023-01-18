// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:app_port_cap/app/auxiliary/auxiliary.dart';
import 'package:app_port_cap/app/controllers/index.dart';
import 'package:app_port_cap/app/models/index.dart';
import 'package:app_port_cap/app/resources/app_colors.dart';
import 'package:app_port_cap/app/system/index.dart';
import 'package:app_port_cap/app/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final UserModel userData;
  final datastore = GetStorage();
  bool camera = false, location = false, notification = false;

  TextStyle headingStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red);

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    var result = datastore.read('user');
    // bool camera =  (Permission.camera.request().isGranted) ? true : false;
    // bool location =
    //     await (Permission.location.request().isGranted) ? true : false;
    // bool notification =
    //     await (Permission.notification.request().isGranted) ? true : false;

    // print(result);
    dynamic jsonData = jsonDecode(result);
    userData = UserModel.fromMap(jsonData);
    _initPackageInfo();
    super.initState();
  }

  bool lockAppSwitchVal = true;
  bool fingerprintSwitchVal = false;
  bool changePassSwitchVal = true;
  TextStyle headingStyleIOS = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: CupertinoColors.inactiveGray,
  );
  TextStyle descStyleIOS = const TextStyle(color: CupertinoColors.inactiveGray);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: TTCCorpColors.Gray,
        appBar: buildAppBar(context, userData.name, leadingEnable: true),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "settings.system.title".tr,
                      style: headingStyle,
                    ),
                  ],
                ),
                languageListTile(context),
                // ListTile(
                //   leading: const Icon(Icons.language),
                //   title: Text('settings.language'.tr),
                //   subtitle: const Text(controller.currentLanguage),
                //   onTap: () => buildLanguageDialog(context,controller.currentLanguage),
                // ),
                const Divider(),
                // const ListTile(
                //   leading: Icon(Icons.cloud),
                //   title: Text("Environment"),
                //   subtitle: Text("Production"),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("settings.account.title".tr, style: headingStyle),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.mail),
                  title: Text('auth.email.label'.tr),
                  subtitle: Text(userData.email.toString()),
                ),
                const Divider(),
                ListTile(
                  tileColor: TTCCorpColors.Red,
                  leading: const Icon(Icons.exit_to_app),
                  title: Text('settings.account.label.signOut'.tr),
                  onTap: () => {AuthController().signOut()},
                ),
                const Divider(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Permission", style: headingStyle),
                  ],
                ),
                ListTile(
                  // leading: const Icon(Icons.exit_to_app),
                  title: const Text('Camera'),
                  subtitle: camera
                      ? const Text('Camera Permission is granted')
                      : const Text('Camera Permission is denied'),
                  onTap: () async {
                    if (await Permission.camera.request().isGranted) {
                      camera = true;
                    } else {
                      camera = false;
                    }
                  },
                ),

                ListTile(
                  // leading: const Icon(Icons.exit_to_app),
                  title: const Text('Location'),
                  subtitle: location
                      ? const Text('Location Permission is granted')
                      : const Text('Location Permission is denied.'),
                  onTap: () async {
                    if (await Permission.location.request().isGranted) {
                      location = true;
                    } else {
                      location = false;
                    }
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.exit_to_app),
                  title: const Text('Notification'),
                  subtitle: notification
                      ? const Text('Notification Permission is granted')
                      : const Text('Notification Permission is denied'),
                  onTap: () async {
                    if (await Permission.notification.request().isGranted) {
                      notification = true;
                    } else {
                      notification = false;
                    }
                  },
                ),
                const Divider(),

                // ListTile(
                //   leading: const Icon(Icons.phonelink_lock_outlined),
                //   title: const Text("Lock app in background"),
                //   trailing: Switch(
                //       value: lockAppSwitchVal,
                //       activeColor: Colors.redAccent,
                //       onChanged: (val) {
                //         setState(() {
                //           lockAppSwitchVal = val;
                //         });
                //       }),
                // ),
                // const Divider(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Text("Permission", style: headingStyle),
                //   ],
                // ),
                // ListTile(
                //   leading: const Icon(Icons.fingerprint),
                //   title: const Text("Use fingerprint"),
                //   trailing: Switch(
                //       value: fingerprintSwitchVal,
                //       activeColor: Colors.redAccent,
                //       onChanged: (val) {
                //         setState(() {
                //           fingerprintSwitchVal = val;
                //         });
                //       }),
                // ),
                // const Divider(),
                // ListTile(
                //     leading: const Icon(Icons.lock),
                //     title: const Text("Change App Password"),
                //     onTap: () async {}),
                // const Divider(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('settings.application.additional'.tr,
                        style: headingStyle),
                  ],
                ),
                ListTile(
                  title: Text('settings.application'.tr),
                  subtitle: Column(children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('settings.application.label.packageName'.tr),
                        Text(_packageInfo.packageName)
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('settings.application.label.ver'.tr),
                        Text(_packageInfo.version)
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('settings.application.label.build'.tr),
                        Text(_packageInfo.buildNumber)
                      ],
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  languageListTile(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (controller) => ListTile(
        leading: const Icon(Icons.language),
        title: Text('settings.language.title'.tr),
        subtitle: Text('${'lang.localeFlag'.tr}  ${'lang.localeName'.tr}  '),
        onTap: () => Globals.buildLanguageDialog(context),
      ),
    );
  }
}
