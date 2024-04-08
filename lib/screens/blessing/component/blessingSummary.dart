import 'package:flutter/material.dart';
import 'package:pocket_siddur/models/blessings.dart';
import 'package:pocket_siddur/size_config.dart';

import '../../../app_properties.dart';
import '../../../enum.dart';
import '../../home/components/customAppBar.dart';
import '../../home/components/custom_bottom_bar.dart';

class BlessingSummaryPage extends StatelessWidget {
  final Blessing blessing;
  bool? isFromHomepage;
  final String? route;

  BlessingSummaryPage({
    required this.blessing,
    this.isFromHomepage,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          AppBar().preferredSize.height,
        ),
        child: CustomAppBar(
          name: blessing.name,
          isFromHomePage: isFromHomepage,
          routeName: route,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          getProportionateScreenHeight(8),
        ),
        child: SingleChildScrollView(
          child: Text(
            blessing.description,
            style: TextStyle(
              color: Colors.white,
              fontSize: getProportionateScreenHeight(15),
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedMenu: NavBarMenuState.blessings,
      ),
    );
  }

}
