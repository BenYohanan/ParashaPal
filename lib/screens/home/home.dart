import 'package:intl/intl.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:pocket_siddur/enum.dart';
import 'package:pocket_siddur/models/parashaAndShabbathService.dart';
import 'package:pocket_siddur/provider/provider.dart';
import 'package:kosher_dart/kosher_dart.dart';
import 'package:pocket_siddur/size_config.dart';
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
    if (todaysEvent.contains(parasha)) {
      todaysEvent = "It\ns Yom Shabbath";
    }
    String shabbathTime =
        '${DateFormat.E().addPattern('jm').format(startTime)} - ${DateFormat.E().addPattern('jm').format(endTime)}';
    var foundParasha = parashaList.where((x) => x.contains(parasha)).first;
    List<String> details = foundParasha.split('\n');
    String torah = details[1].replaceAll('- Torah: ', '');
    String haftarah = details[2].replaceAll('- Haftarah: ', '');
    String britChadasha = details[3].replaceAll('- Brit Chadashah: ', '');
    GetStoredDataFromSharedPreference().storeData("torah", torah);
    GetStoredDataFromSharedPreference().storeData("haftarah", haftarah);
    GetStoredDataFromSharedPreference().storeData("britChadasha", britChadasha);
    GetStoredDataFromSharedPreference().storeData("todaysDate", today);
    GetStoredDataFromSharedPreference().storeData("parasha", parasha);
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
                  left: 16.0,
                  right: 8.0,
                ),
                width: 4,
                color: mediumYellow,
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
                torahReading: torah,
                hafTorah: haftarah,
                britChadasha: britChadasha,
                shabbathTime: shabbathTime,
                parasha: parasha,
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
