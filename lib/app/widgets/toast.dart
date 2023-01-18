import 'package:app_port_cap/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastmessage(String msg, Color color) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 4,
  );
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
