import 'package:flutter/material.dart';
import 'package:pocket_siddur/size_config.dart';

import '../../custom_background.dart';
import '../../enum.dart';
import '../../models/blessings.dart';
import '../home/components/customAppBar.dart';
import '../home/components/custom_bottom_bar.dart';
import 'component/blessingCard.dart';
import 'component/blessingSummary.dart';

class BlessingScreen extends StatefulWidget {
  const BlessingScreen({super.key});

  @override
  State<BlessingScreen> createState() => _BlessingScreenState();
  static String routeName = "/blessingScreen";
}

class _BlessingScreenState extends State<BlessingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          AppBar().preferredSize.height,
        ),
        child: CustomAppBar(
          name: "Berakah",
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
              itemCount: blessings.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => BlessingSummaryPage(
                          blessing: blessings[index],
                          isFromHomepage: true,
                          route: BlessingScreen.routeName,
                        ),
                      ),
                    );
                  },
                  child: BlessingScreenCard(
                    blessing: blessings[index],
                  ),
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
