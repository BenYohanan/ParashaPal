import 'dart:async';

import 'package:in_app_update/in_app_update.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:pocket_siddur/enum.dart';
import 'package:pocket_siddur/models/parasha.dart';
import 'package:pocket_siddur/provider/provider.dart';
import 'package:pocket_siddur/size_config.dart';
import 'package:provider/provider.dart';
import '../../models/prayer.dart';

import 'components/custom_bottom_bar.dart';
import 'components/prayerList.dart';
import 'components/weeklyParasha.dart';

class MainPage extends StatefulWidget {
  static String routeName = "/mainPageScreen";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    print('checking for update');
    InAppUpdate.checkForUpdate().then((value) {
      setState(() {
        if (value.updateAvailability == UpdateAvailability.updateAvailable) {
          print('update available');
          update();
        }
      });
    });
  }

  void update() async {
    print('updating');
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
      print(e.toString());
    });
  }

  String lightingTime = "";
  String today = "";
  String location = "";
  List<String> events = [];
  late Parasha? parasha;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderService>(context, listen: false);
    lightingTime = provider.getLightingTime;
    events = provider.getEvents;
    parasha = provider.getParasha;
    today = provider.getTodaysFormattedDate;
    location = provider.getLocationName;
    Widget todaysDate = Padding(
      padding: EdgeInsets.all(
        getProportionateScreenHeight(20),
      ),
      child: SizedBox(
        height: getProportionateScreenHeight(35),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            IntrinsicHeight(
              child: Container(
                margin: const EdgeInsets.only(
                  right: 8.0,
                ),
                width: 4,
                color: primaryColor,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Today: ${today}",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: getProportionateScreenHeight(13),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(2),
                  ),
                  Text(
                    location,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: getProportionateScreenHeight(12),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      body: CustomPaint(
        painter: MainBackground(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              todaysDate,
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              PrayerList(
                prayer: prayers,
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              WeeklyParashah(
                shabbathTime: lightingTime,
                todaysEvent: events,
                parasha: parasha,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedMenu: NavBarMenuState.home,
      ),
    );
  }
}
