import 'package:flutter/material.dart';
import 'package:photo_sender/utils/language_util.dart';

void showSnackBar(String? message, BuildContext context) {
  final snackBar = SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      content: SizedBox(
          height: 50,
          child: Text(message ?? LanguageUtil.unknownMessage)
      )
  );
  //remove old SnackBar
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}