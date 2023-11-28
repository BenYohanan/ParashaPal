import 'package:intl/intl.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:pocket_siddur/enum.dart';
import 'package:pocket_siddur/models/parasha.dart';
import 'package:pocket_siddur/provider/provider.dart';
import 'package:kosher_dart/kosher_dart.dart';
import 'package:pocket_siddur/size_config.dart';
import '../../models/prayer.dart';
import 'components/custom_bottom_bar.dart';
import 'components/prayerList.dart';
import 'components/weeklyParasha.dart';

class MainPage extends StatelessWidget {
  JewishDate jewishDate = JewishDate();
  JewishCalendar jewishCalendar = JewishCalendar();
  HebrewDateFormatter hebrewDateFormatter = HebrewDateFormatter();
  ComplexZmanimCalendar complexZmanimCalendar = ComplexZmanimCalendar();
  HebrewDateFormatter translatedDateFormatter = HebrewDateFormatter()
    ..hebrewFormat = false;
  static String routeName = "/mainPageScreen";
  @override
  Widget build(BuildContext context) {
    var parasha = translatedDateFormatter.formatWeeklyParsha(
      jewishCalendar,
    );
    var today = translatedDateFormatter.format(
      jewishDate,
    );
    var startTime =
        complexZmanimCalendar.getShabbosStartTime().add(Duration(hours: 1));
    var endTime =
        complexZmanimCalendar.getShabbosExitTime().add(Duration(hours: 1));
    var todaysEvent = translatedDateFormatter.getEvent(jewishCalendar);
    var dayofWeek = translatedDateFormatter.formatDayOfWeek(jewishCalendar);
    if (todaysEvent.contains(parasha)) {
      todaysEvent = "It's Yom Shabbath";
    }
    if (dayofWeek == "Fri" && todaysEvent.isEmpty) {
      todaysEvent =
          "It's Erev Shabbath ${parasha}, prepare to welcome the bride.";
    }
    String shabbathTime =
        '${DateFormat.E().addPattern('jm').format(startTime)} - ${DateFormat.E().addPattern('jm').format(endTime)}';
    var foundParasha = parashot.where((x) => x.name.contains(parasha)).first;
    GetStoredDataFromSharedPreference().storeData(
      "torah",
      foundParasha.torah,
    );
    GetStoredDataFromSharedPreference().storeData(
      "haftarah",
      foundParasha.haftarah,
    );
    GetStoredDataFromSharedPreference().storeData(
      "britChadasha",
      foundParasha.britChadashah,
    );
    GetStoredDataFromSharedPreference().storeData(
      "parasha",
      foundParasha.name,
    );
    GetStoredDataFromSharedPreference().storeData("todaysDate", today);
    GetStoredDataFromSharedPreference().storeData("shabbathTime", shabbathTime);
    Widget todaysDate = Padding(
      padding: EdgeInsets.all(
        getProportionateScreenHeight(20),
      ),
      child: SizedBox(
        height: getProportionateScreenHeight(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            IntrinsicHeight(
              child: Container(
                margin: const EdgeInsets.only(
                  right: 8.0,
                ),
                width: 4,
                color: transparentYellow,
              ),
            ),
            Center(
              child: Text(
                "Today: ${DateFormat.yMMMd().format(DateTime.now())} | $today",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.bold,
                ),
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
                torahReading: foundParasha.torah,
                hafTorah: foundParasha.haftarah,
                britChadasha: foundParasha.britChadashah,
                shabbathTime: shabbathTime,
                parasha: foundParasha.name,
                todaysEvent: todaysEvent,
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
