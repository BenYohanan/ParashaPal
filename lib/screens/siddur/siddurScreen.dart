import 'package:flutter/material.dart';
import 'package:pocket_siddur/models/prayer.dart';
import 'package:pocket_siddur/size_config.dart';

import '../../custom_background.dart';
import '../../enum.dart';
import '../home/components/customAppBar.dart';
import '../home/components/custom_bottom_bar.dart';
import 'component/siddurCard.dart';

class SiddurScreen extends StatefulWidget {
  const SiddurScreen({super.key});

  @override
  State<SiddurScreen> createState() => _SiddurScreenState();
  static String routeName = "/siddurScreen";
}

class _SiddurScreenState extends State<SiddurScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          AppBar().preferredSize.height,
        ),
        child: CustomAppBar(
          name: "Shabbath Siddur",
        ),
      ),
      body: CustomPaint(
          painter: MainBackground(),
          child: Padding(
            padding: EdgeInsets.all(
              getProportionateScreenWidth(10),
            ),
            child: ListView.builder(
              itemCount: prayers.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: SiddurScreenCard(
                  shabbathSiddur: prayers[index],
                ),
              ),
            ),
          )),
      bottomNavigationBar: CustomBottomBar(
        selectedMenu: NavBarMenuState.siddur,
      ),
    );
  }
}
