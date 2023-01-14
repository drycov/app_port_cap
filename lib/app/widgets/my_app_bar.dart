import 'package:app_port_cap/app/auxiliary/auxiliary.dart';
import 'package:app_port_cap/app/controllers/index.dart';
import 'package:app_port_cap/app/resources/resources.dart';
import 'package:app_port_cap/app/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget buildAppBar(BuildContext context, String? uName,
    {bool? leadingEnable = true}) {
  String userName = uName!;
  Globals.printMet(leadingEnable);

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton(
        offset: const Offset(0, 45),
        iconSize: 30,
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
        },
        onSelected: (value) {
          if (value == 0) {
            Get.toNamed("/profile");
          } else if (value == 1) {
            Get.toNamed('/settings');
          } else if (value == 2) {
            AuthController().signOut();
          }
        });
  }

  if (!leadingEnable!) {
    return AppBar(
      iconTheme: const IconThemeData(color: TTCCorpColors.White), //
      actionsIconTheme: const IconThemeData(),
      elevation: 0,
      backgroundColor: TTCCorpColors.Salem,
      actions: [_buildPopupMenu(context)],
    );
  } else {
    return AppBar(
      iconTheme: const IconThemeData(color: TTCCorpColors.White), //
      actionsIconTheme: const IconThemeData(),
      elevation: 0,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Get.back();
          }),
      backgroundColor: TTCCorpColors.Salem,
      actions: [_buildPopupMenu(context)],
    );
  }
}
