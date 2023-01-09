// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:app_port_cap/app/models/index.dart';
import 'package:app_port_cap/app/resources/app_colors.dart';
import 'package:app_port_cap/app/widgets/index.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tiny_avatar/tiny_avatar.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({Key? key}) : super(key: key);
  static const String id = 'home_page';

  @override
  State<HomeUi> createState() => _HomeUi();
}

class _HomeUi extends State<HomeUi> {
  final datastore = GetStorage();
  late final UserModel userData;

  @override
  void initState() {
    super.initState();
    final datastore = GetStorage();
    var result = datastore.read('user');
    // print(result);
    dynamic jsonData = jsonDecode(result);
    userData = UserModel.fromMap(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: TTCCorpColors.White,
        // bottomNavigationBar: const CustomNavigationBar(),
        // bottomNavigationBar: BottomNavigationBar(items: []),
        drawer: _buildDraver(context),

        //! change user name
        appBar: buildAppBar(context, userData.name),
        // ===================== BODY ========================== //
        body: Column(
          children: const [],
        ));
  }

  Widget _buildDraver(BuildContext context) {
    return Drawer(
      backgroundColor: TTCCorpColors.White,
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
            icon: Icons.bug_report,
            text: 'Report an issue',
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: TTCCorpColors.Salem),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text!,
              style: const TextStyle(color: TTCCorpColors.Salem),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createHeader(String? uName) {
    String userName = uName!;

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
          const Positioned(
            child: Text(
              'Oskementranstelecom',
              style: TextStyle(color: TTCCorpColors.White),
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
}
