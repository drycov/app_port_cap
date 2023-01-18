// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:app_port_cap/app/auxiliary/auxiliary.dart';
import 'package:app_port_cap/app/controllers/index.dart';
import 'package:app_port_cap/app/models/index.dart';
import 'package:app_port_cap/app/resources/app_colors.dart';
import 'package:app_port_cap/app/widgets/index.dart';
import 'package:app_port_cap/app/widgets/main_menu/grid_dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({Key? key}) : super(key: key);
  static const String id = 'home_page';

  @override
  State<HomeUi> createState() => _HomeUi();
}

class _HomeUi extends State<HomeUi> {
  final datastore = GetStorage();
  late final UserModel userData;
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  final AuthController controller = AuthController.to;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Items item1 = Items(
      title: "home.menu.title.networkStructure".tr,
      subtitle: "home.menu.subtitle.networkStructure".tr,
      event: "95 devices",
      img: Icons.group_work_rounded,
      onTap: () => {
            Get.toNamed('/ns')
            // print("Network structure"),
            // toastmessage('Network structure', TTCCorpColors.ForestGreen)
          },
      cardColor: TTCCorpColors.Apple);
  Items item2 = Items(
      title: "home.menu.title.lineStructure".tr,
      subtitle: "home.menu.subtitle.lineStructure".tr,
      event: " ",
      img: Icons.polyline_outlined,
      onTap: () => {
            print("Line structure"),
            toastmessage('Line structure', TTCCorpColors.ForestGreen)
          },
      cardColor: TTCCorpColors.Apple);
  Items item3 = Items(
      title: "home.menu.title.location".tr,
      subtitle: "home.menu.subtitle.location".tr,
      event: "",
      onTap: () => {
            print("Locations"),
            toastmessage('Locations', TTCCorpColors.ForestGreen)
          },
      img: Icons.location_on_outlined,
      cardColor: TTCCorpColors.Apple);
  Items item4 = Items(
      title: "home.menu.title.documents".tr,
      subtitle: 'home.menu.subtitle.documents'.tr,
      event: "",
      onTap: () => {
            print("Documents"),
            toastmessage('Documents', TTCCorpColors.ForestGreen)
          },
      img: Icons.description_outlined,
      cardColor: TTCCorpColors.Apple);
  Items item5 = Items(
      title: "home.menu.title.portCapacity".tr,
      subtitle: 'home.menu.subtitle.portCapacity'.tr,
      event: " ",
      onTap: () => {
            print("Port Capacity"),
            toastmessage('Port Capacity', TTCCorpColors.ForestGreen)
          },
      img: Icons.settings_input_hdmi_outlined,
      cardColor: TTCCorpColors.Apple);
  Items item6 = Items(
      title: "home.menu.title.employers".tr,
      subtitle: 'home.menu.subtitle.employers'.tr,
      event: " ",
      onTap: () => {
            print("Employers"),
            toastmessage('Employers', TTCCorpColors.ForestGreen)
          },
      img: Icons.reduce_capacity_outlined,
      cardColor: TTCCorpColors.Apple);

  // List<Items> myList = [item1, item2, item3, item4, item5, item6];

  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    // });

    final datastore = GetStorage();

    var result = datastore.read('user');
    // print(result);
    dynamic jsonData = jsonDecode(result);
    userData = UserModel.fromMap(jsonData);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: TTCCorpColors.Gray,
        // bottomNavigationBar: const CustomNavigationBar(),
        // bottomNavigationBar: BottomNavigationBar(items: []),
        drawer: _buildDraver(context),

        //! change user name
        appBar: buildAppBar(context, userData.name, leadingEnable: false),
        // ===================== BODY ========================== //
        body: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: _createHomeMenu(context)),
      ),
    );
  }

  Widget _buildDraver(BuildContext context) {
    return Drawer(
      backgroundColor: TTCCorpColors.Gray,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //!change userName
          _createHeader(userData.firstName),
          // const CircularProgressIndicator(),
          // _createDrawerItem(
          //   icon: Icons.contacts,
          //   text: 'Contacts',
          //   onTap: () {},
          // ),
          _createDrawerItem(
            icon: Icons.event,
            text: 'Events',
            onTap: () async {
              await _db
                  .collection('users')
                  .doc(userData.uid)
                  .get()
                  .then((documentSnapshot) => {
                        Globals.printMet('USer', documentSnapshot.data()),
                        UserModel.fromMap(documentSnapshot.data()!),
                        UserModel().copy()
                      });
              Globals.printMet('isAdmin', UserModel().toJson());
            },
          ),
          _createDrawerItem(
            icon: Icons.note,
            text: 'Notes',
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.stars,
            text: 'Useful Links',
          ),
          const Divider(),
          _createDrawerItem(
              icon: Icons.report_outlined,
              text: 'drawer.item.label.support'.tr,
              color: TTCCorpColors.Salem,
              onTap: (() => {Get.toNamed('/chat')})),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData? icon,
      String? text,
      Color color = TTCCorpColors.Black,
      GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: color),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text!,
              style: TextStyle(color: color),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createHeader(String? uName) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
          color: TTCCorpColors.Salem,
        ),
        child: Stack(children: <Widget>[
          Positioned(
            child: GestureDetector(
              onTap: () {
                var result = datastore.read('user');
                print(result);
              },
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 5, color: Colors.white)),
                    child: AvatarWidget(
                      useLetterAvatar: true,
                      dimension: 80,
                      userName: userData.name,
                      firstName: userData.firstName,
                      lastName: userData.lastName,
                    ),
                  )),
            ),
            top: 16,
            left: 16,
          ),
          Positioned(
            child: Text(
              '${userData.firstName} ${userData.lastName}',
              // controller.firestoreUser.value!.name.toString(),
              style: const TextStyle(color: TTCCorpColors.White),
            ),
            right: 16,
            top: 32,
          ),
          Positioned(
            child: Text(
              '${userData.email}',
              // controller.firestoreUser.value!.email.toString(),
              style: const TextStyle(color: TTCCorpColors.White),
            ),
            right: 16,
            top: 48,
          ),
          Positioned(
            child: Text(
              userData.cn.toString(),
              style: const TextStyle(color: TTCCorpColors.White),
            ),
            right: 16,
            top: 64,
          ),
          Positioned(
            child: Text(
              '${userData.post}',
              // controller.firestoreUser.value!.post.toString(),
              style: const TextStyle(color: TTCCorpColors.White),
            ),
            right: 16,
            top: 80,
          ),
        ]));
  }

  Widget _createHomeMenu(BuildContext context) {
    return Column(
      children: <Widget>[
        // const SizedBox(height: 110),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
              decoration: const BoxDecoration(
                  color: TTCCorpColors.Apple,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        userData.cn.toString(),
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: TTCCorpColors.White,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userData.region.toString(),
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: TTCCorpColors.White,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ],
              ),
            )),
        const SizedBox(height: 16),
        GridDashboard(
          myList: [item1, item2, item3, item4, item5, item6],
        )
      ],
    );
  }
}
