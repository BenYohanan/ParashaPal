import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_siddur/app_properties.dart';

import '../../../size_config.dart';

class CustomAppBar extends StatelessWidget {
  final String name;

  CustomAppBar({required this.name});
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
                  onPressed: () => Navigator.pop(context),
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
            ],
          ),
        ),
      ),
    );
  }
}
