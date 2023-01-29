// ignore_for_file: avoid_print

import 'package:app_port_cap/app/auxiliary/auxiliary.dart';
import 'package:app_port_cap/app/controllers/index.dart';
import 'package:app_port_cap/app/resources/app_colors.dart';
import 'package:app_port_cap/app/system/index.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthUI extends StatefulWidget {
  const AuthUI({super.key});

  @override
  State<AuthUI> createState() => _AuthUI();
}

class _AuthUI extends State<AuthUI> with SingleTickerProviderStateMixin {
  final AuthController authController = AuthController.to;
  bool _passwordVisible = true;
  final datastore = GetStorage();

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
    // datastore.write("pi", info);
    setState(() {
      _packageInfo = info;
    });
    if (datastore.read('locale') != null) {}
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  // updateLanguage(Locale locale) {
  //   Get.back();
  //   Get.updateLocale(locale);
  // }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return GetBuilder<LanguageController>(
            builder: (controller) => AlertDialog(
              backgroundColor: TTCCorpColors.ClearDay,
              title: Text(
                'choseLangTitle'.tr,
                style: const TextStyle(color: TTCCorpColors.Salem),
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Globals.locale[index]['flag'],
                              ),
                              const SizedBox(
                                width: 5,
                                height: 0,
                              ),
                              Text(
                                Globals.locale[index]['name'],
                                style: const TextStyle(
                                  color: TTCCorpColors.Salem,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          onTap: () async {
                            // datastore.write("locale", _lang);

                            // updateLanguage(Globals.locale[index]['locale']);

                            await controller.updateLanguage(
                                Globals.locale[index]['langCode']!);
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

  void fireToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: TTCCorpColors.Red,
        textColor: TTCCorpColors.White,
        fontSize: 16.0);
  }

  void fireToast2(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: TTCCorpColors.Salem,
        textColor: TTCCorpColors.White,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  TTCCorpColors.Salem,
                  TTCCorpColors.ForestGreen,
                  TTCCorpColors.Apple,
                  TTCCorpColors.Lima,
                  TTCCorpColors.Sushi,
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 210,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_packageInfo.appName,
                              style: const TextStyle(
                                  color: TTCCorpColors.White, fontSize: 30)),
                          IconButton(
                            onPressed: (() {
                              Globals.buildLanguageDialog(context);
                            }),
                            icon: const Icon(
                              Icons.language,
                              color: TTCCorpColors.White,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7.5),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: TTCCorpColors.Peppermint,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: _buildFormBackGround(
                          context, _buildForm(context), _buildFooter(context))),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildFormBackGround(
      BuildContext context, Widget _form, Widget _footer) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 60),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 10,
                      offset: const Offset(0, 10)),
                ]),
            child: _form,
          ),
          const SizedBox(height: 35),
          ConnectivityWidgetWrapper(
            disableInteraction: true,
            stacked: false,
            offlineWidget: MaterialButton(
              onPressed: null,
              color: Colors.green.shade700,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    const Text(
                      "Connecting",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 60),
                    const CupertinoActivityIndicator(
                      radius: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            child: MaterialButton(
              onPressed: _sendToServer,
              height: 45,
              minWidth: 240,
              child: Text(
                'auth.signIn.label'.tr,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
              color: Colors.green.shade700,
              shape: const StadiumBorder(),
            ),
          ),
          _footer
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextFormField(
          onSaved: (value) => authController.emailController.text = value!,
          validator: (val) => val?.length == null ? 'Username Required' : null,
          controller: authController.emailController,
          style: const TextStyle(fontSize: 15),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: InputBorder.none,
              hintText: 'auth.email.label'.tr,
              isCollapsed: false,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey)),
        ),
        const Divider(color: Colors.black54, height: 1),

        /// PASSWORD
        TextFormField(
          controller: authController.passwordController,
          onSaved: (value) => authController.passwordController.text = value!,
          obscureText: _passwordVisible,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: TTCCorpColors.Salem,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: InputBorder.none,
              hintText: 'auth.password.label'.tr,
              isCollapsed: false,
              hintStyle: const TextStyle(fontSize: 15, color: Colors.grey)),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, right: 30, left: 30),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'msg.info.byLogging'.tr,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
          children: <TextSpan>[
            TextSpan(
                text: 'msg.info.TandC'.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.cyan),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    fireToast2("${'msg.info.TandC'.tr} Hash Tag");
                  }),
            TextSpan(text: 'msg.info.and'.tr),
            TextSpan(
                text: 'msg.info.privacy'.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.cyan),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    fireToast2("${'msg.info.privacy'.tr} Hash Tag");
                  }),
          ],
        ),
      ),
    );
  }

  _sendToServer() async {
    authController.signInWithEmailAndPassword(context);
  }
}

class LoginRequestData {
  String email = '';
  String password = '';
}
