import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:pocket_siddur/enum.dart';
import 'package:pocket_siddur/helpers/helpers.dart';
import 'package:pocket_siddur/screens/home/components/verseOfTheday.dart';
import 'package:pocket_siddur/size_config.dart';
import 'package:pocket_siddur/helpers/home_screen_details.dart';
import '../../models/prayer.dart';

import 'components/custom_bottom_bar.dart';
import 'components/prayerList.dart';
import 'components/weeklyParasha.dart';

class MainPage extends ConsumerStatefulWidget {
  static String routeName = "/mainPageScreen";

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((value) {
      setState(() {
        if (value.updateAvailability == UpdateAvailability.updateAvailable) {
          update();
        }
      });
    });
  }

  void update() async {
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = ref.read(providerServiceProvider.notifier);
    var today = ref.watch(providerServiceProvider).getTodaysFormattedDate;
    var location =
        ref.watch(providerServiceProvider).getUserLocation.locationName!;
    if (location.isEmpty) {
      Helper().updateHomeScreenDetails(provider);
    }
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
                    today,
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
                height: getProportionateScreenHeight(5),
              ),
              todaysDate,
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              PrayerList(
                prayer: prayers,
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              VerseOfTheDayCard(),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              WeeklyParashah(),
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
