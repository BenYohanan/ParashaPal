import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kosher_dart/kosher_dart.dart';
import 'package:pocket_siddur/provider/provider.dart';
import 'package:provider/provider.dart';

import '../models/parasha.dart';

class Helper {
  JewishDate jewishDate = JewishDate();
  JewishCalendar jewishCalendar = JewishCalendar();
  HebrewDateFormatter hebrewDateFormatter = HebrewDateFormatter();
  ComplexZmanimCalendar complexZmanimCalendar = ComplexZmanimCalendar();
  HebrewDateFormatter translatedDateFormatter = HebrewDateFormatter()
    ..hebrewFormat = false;

  void updateDate(BuildContext context) {
    var provider = context.read<ProviderService>();
    var addedDay = provider.addedDays;
    if (addedDay > 0) {
      jewishCalendar.setDate(DateTime.now().add(Duration(days: addedDay)));
      jewishDate.setDate(DateTime.now().add(Duration(days: addedDay)));
    }
    var todaysHebrewDate = translatedDateFormatter.format(jewishDate);
    var gregorianDate =
        DateFormat.yMMMd().format(DateTime.now().add(Duration(days: 7)));

    provider.updateTodaysDate("$gregorianDate | $todaysHebrewDate");
  }

  void updateEvents(BuildContext context) {
    var provider = context.read<ProviderService>();

    var parasha = translatedDateFormatter.formatWeeklyParsha(jewishCalendar);
    var events = translatedDateFormatter.getEventsList(
      jewishCalendar,
      complexZmanimCalendar,
    );

    var dayOfWeek = translatedDateFormatter.formatDayOfWeek(jewishCalendar);
    if (events.contains(parasha)) {
      events.add("It's Yom Shabbath");
    }
    if (dayOfWeek == "Fri") {
      provider.getEvents.add(
        "It's Erev Shabbath ${parasha}, prepare to welcome the bride.",
      );
    }
    provider.updateEventList(events);
  }

  void updateLightingTimeAndParasha(BuildContext context) {
    var provider = context.read<ProviderService>();

    var startTime =
        complexZmanimCalendar.getShabbosStartTime().add(Duration(hours: 1));
    var endTime =
        complexZmanimCalendar.getShabbosExitTime().add(Duration(hours: 1));

    var lightingTime =
        '${DateFormat.E().addPattern('jm').format(startTime)} - ${DateFormat.E().addPattern('jm').format(endTime)}';

    var parasha = translatedDateFormatter.formatWeeklyParsha(jewishCalendar);
    var weeklyParasha = parashot.where((x) => x.name.contains(parasha)).first;
    provider.updateTodaysDate(lightingTime);
    provider.updateParasha(weeklyParasha);
  }

  void fetchTodayData(BuildContext context) async {
    try {
      updateDate(context);
      updateEvents(context);
      updateLightingTimeAndParasha(context);
    } catch (e) {
      print('Error fetching location: $e');
      // Handle errors here
    }
  }
}
