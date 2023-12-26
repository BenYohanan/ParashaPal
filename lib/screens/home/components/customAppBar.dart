import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/helpers/helpers.dart';

import '../../../size_config.dart';

class CustomAppBar extends StatelessWidget {
  final String name;
  String? routeName;
  bool? isFromHomePage;
  String? shareMessage;
  String? shareSubject;
  Color? shareColor;
  CustomAppBar(
      {required this.name,
      required this.isFromHomePage,
      this.routeName,
      this.shareMessage,
      this.shareColor,
      this.shareSubject});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(
            getProportionateScreenWidth(10),
          ),
          child: Row(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(70),
                width: getProportionateScreenWidth(40),
                child: TextButton(
                  onPressed: () {
                    if (isFromHomePage!) {
                      Navigator.pushNamed(
                        context,
                        routeName!,
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: SvgPicture.asset(
                    "assets/icons/Back Icon.svg",
                    color: darkGrey,
                    height: getProportionateScreenHeight(15),
                  ),
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  color: darkGrey,
                  fontSize: getProportionateScreenHeight(15),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              if (shareMessage != null)
                Helper().SharePrayerTime(
                  context,
                  shareMessage!,
                  subject: shareSubject!,
                  color: shareColor!,
                )
            ],
          ),
        ),
      ),
    );
  }
}
