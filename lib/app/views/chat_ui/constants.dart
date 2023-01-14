import 'package:app_port_cap/app/resources/resources.dart';
import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: TTCCorpColors.Sushi,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: TTCCorpColors.MossGreen),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: TTCCorpColors.Sushi, width: 0.5),
  ),
);
