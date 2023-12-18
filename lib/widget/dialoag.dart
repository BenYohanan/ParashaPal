import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../provider/provider.dart';
import '../size_config.dart';

class promptUser {
  Future<void> collectUserReligiousChoice(
      BuildContext context,
      String cancelButtonText,
      String confirmButtonText,
      String title,
      String textContent) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: modalPrompt(cancelButtonText, TextAlign.left),
      onPressed: () async {
        IsMessianic(false);
      },
    );
    Widget continueButton = TextButton(
      child: modalPrompt(confirmButtonText, TextAlign.right),
      onPressed: () async {
        Navigator.of(context).pop(true);
        IsMessianic(true);
      },
    );

    // set up the AlertDialog
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromARGB(255, 90, 128, 235),
        ),
      ),
      content: Text(
        textContent,
        textAlign: TextAlign.center,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Text modalPrompt(String label, TextAlign position) {
    return Text(
      label,
      textAlign: position,
      style: TextStyle(
        fontSize: getProportionateScreenWidth(15),
      ),
    );
  }
}
