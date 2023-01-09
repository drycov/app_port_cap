import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

// Model class to hold menu option data (language and theme)
class MenuOptionsModel {
  final String langCode;
  final String name;
  final Locale locale;
  final Flag? flag;

  MenuOptionsModel(
      {required this.langCode,
      required this.name,
      required this.locale,
      this.flag});
}

    // {
    //   'name': 'English',
    //   'locale': const Locale('en'),
    //   'langCode': 'en',
    //   'flag': Flag(Flags.united_states_of_america)
    // },