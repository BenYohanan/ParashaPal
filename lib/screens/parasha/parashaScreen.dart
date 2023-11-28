import 'package:flutter/material.dart';
import 'package:pocket_siddur/size_config.dart';

import '../../custom_background.dart';
import '../../enum.dart';
import '../../models/parasha.dart';
import '../home/components/customAppBar.dart';
import '../home/components/custom_bottom_bar.dart';
import 'component/parashaCard.dart';

class ParaShaScreen extends StatefulWidget {
  const ParaShaScreen({super.key});

  @override
  State<ParaShaScreen> createState() => _ParaShaScreenState();
  static String routeName = "/parashaScreen";
}

class _ParaShaScreenState extends State<ParaShaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          AppBar().preferredSize.height,
        ),
        child: CustomAppBar(
          name: "Parashot",
        ),
      ),
      body: CustomPaint(
          painter: MainBackground(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: ListView.builder(
              itemCount: parashot.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: ParashaScreenCard(
                  parasha: parashot[index],
                ),
              ),
            ),
          )),
      bottomNavigationBar: CustomBottomBar(
        selectedMenu: NavBarMenuState.parasha,
      ),
    );
  }
}
