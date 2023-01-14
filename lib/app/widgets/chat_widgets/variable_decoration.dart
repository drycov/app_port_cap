import 'package:flutter/material.dart';

Function kTextFieldDecoration = (kButtonBorderColor) => InputDecoration(
      hintText: 'Enter your email',
      hintStyle: const TextStyle(color: Color(0xFFB0BEC5)),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kButtonBorderColor, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kButtonBorderColor, width: 2.0),
        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
      ),
    );
