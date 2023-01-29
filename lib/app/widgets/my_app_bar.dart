import 'package:app_port_cap/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

PreferredSizeWidget buildAppBar(BuildContext context, String? uName,
    {bool? leadingEnable = true}) {
  bool _isVisible = true;
  final datastore = GetStorage();
  ((datastore.read('admin') == null) ? datastore.read('admin') : false)
      ? _isVisible
      : !_isVisible;

  _buildActionMenu(context) {
    return [
      Visibility(
        visible: (datastore.read('admin') != null)
            ? ((datastore.read('admin')) ? _isVisible : !_isVisible)
            : false,
        child: IconButton(
            onPressed: () => {_isVisible = !_isVisible},
            icon: const Icon(Icons.admin_panel_settings_outlined)),
      ),

      Visibility(
        visible: (Get.currentRoute != '/profile') ? _isVisible : !_isVisible,
        child: IconButton(
            onPressed: () => Get.toNamed("/profile"),
            icon: const Icon(Icons.person_outlined)),
      ),
      Visibility(
        visible: (Get.currentRoute != '/settings') ? _isVisible : !_isVisible,
        child: IconButton(
            onPressed: () => Get.toNamed('/settings'),
            icon: const Icon(Icons.settings_outlined)),
      ),

      // _buildPopupMenu(context)
    ];
  }

  if (!leadingEnable!) {
    return AppBar(
      iconTheme: const IconThemeData(color: TTCCorpColors.White), //
      actionsIconTheme: const IconThemeData(),
      // elevation: 0,
      backgroundColor: (datastore.read('admin') != null)
          ? ((datastore.read('admin'))
              ? TTCCorpColors.Red
              : TTCCorpColors.Salem)
          : TTCCorpColors.Salem,

      actions: _buildActionMenu(context),
    );
  } else {
    return AppBar(
      iconTheme: const IconThemeData(color: TTCCorpColors.White), //
      actionsIconTheme: const IconThemeData(),
      // elevation: 0,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Get.back();
          }),
      backgroundColor: (datastore.read('admin') != null)
          ? ((datastore.read('admin'))
              ? TTCCorpColors.Red
              : TTCCorpColors.Salem)
          : TTCCorpColors.Salem,
      actions: _buildActionMenu(context),
    );
  }
}
