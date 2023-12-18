import 'package:pocket_siddur/models/blessings.dart';
import 'package:flutter/material.dart';
import 'package:pocket_siddur/size_config.dart';

import '../../custom_background.dart';
import '../../enum.dart';
import '../home/components/customAppBar.dart';
import '../home/components/custom_bottom_bar.dart';
import 'components/blessingCard.dart';

class BlessingsScreen extends StatefulWidget {
  @override
  State<BlessingsScreen> createState() => _BlessingsScreenState();
  static String routeName = "/blessingsScreen";
}

class _BlessingsScreenState extends State<BlessingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          AppBar().preferredSize.height,
        ),
        child: CustomAppBar(
          name: "Blessings",
          isFromHomePage: false,
        ),
      ),
      body: CustomPaint(
          painter: MainBackground(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: ListView.builder(
              itemCount: blessing.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: BlessingCard(
                  audioBlessing: blessing[index],
                ),
              ),
            ),
          )),
      bottomNavigationBar: CustomBottomBar(
        selectedMenu: NavBarMenuState.blessings,
      ),
    );
  }
}
