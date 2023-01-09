import 'package:app_port_cap/app/controllers/index.dart';
import 'package:app_port_cap/app/resources/resources.dart';
import 'package:app_port_cap/app/widgets/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiny_avatar/tiny_avatar.dart';

PreferredSizeWidget buildAppBar(BuildContext context, String? uName) {
  String userName = uName!;
  return AppBar(
    actionsIconTheme: const IconThemeData(),
    // leading: IconButton(
    //     icon: const Icon(Icons.arrow_back_ios_new_outlined),
    //     onPressed: () {
    //       Get.back();
    //     }),
    elevation: 0,
    backgroundColor: TTCCorpColors.Salem,
    title: Center(
      child: GestureDetector(
        onTap: () {
          toastmessage('Search Bar');
          if (kDebugMode) {
            print('Search Bar');
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: TTCCorpColors.White,
              borderRadius: BorderRadius.circular(50)),
          height: 32,
          width: 310,
          child: const SearchBar(),
        ),
      ),
    ),
    actions: [
      PopupMenuButton(
          // add icon, by default "3 dot" icon
          // icon: Icon(Icons.book)
          itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            value: 0,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(userName),
                  AvatarWidget(
                    useLetterAvatar: true,
                    dimension: 32,
                    userName: userName,
                  ),
                ]),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: Text('settings.settings.title'.tr),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Text('settings.account.label.signOut'.tr),
          ),
        ];
      }, onSelected: (value) {
        if (value == 0) {
          if (kDebugMode) {
            print("My account menu is selected.");
          }
        } else if (value == 1) {
          Get.toNamed('/settings');
        } else if (value == 2) {
          AuthController().signOut();
        }
      }),
      //   Padding(
      //     padding: const EdgeInsets.only(right: 10, left: 10),
      //     child: GestureDetector(
      //         onTap: () => Globals.printMet('Profile'),
      //         child: TinyAvatar(
      //           baseString: userName,
      //           dimension: 32,
      //           circular: true,
      //         )
      //         // const CircleAvatar(
      //         //   backgroundColor: TTCCorpColors.White,
      //         //   // backgroundImage:
      //         //   //     AssetImage("assets/images/avatars/default.png"),
      //         //   radius: 18,
      //         //   child: AvatarWidget(
      //         //     female: true,
      //         //     shape: Shape.Circular,
      //         //   ),
      //         // ),
      //         ),
      //   ),
      //
    ],
  );
}
