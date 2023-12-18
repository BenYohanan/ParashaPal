import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kosher_dart/kosher_dart.dart';
import 'package:pocket_siddur/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:yaml/yaml.dart';

import '../models/parasha.dart';

class Helper {
  void getAndSetLocation(BuildContext context) async {
    final provider = Provider.of<ProviderService>(context, listen: false);
    GeoLocation geoLocation = GeoLocation.setLocation(
      provider.getLocationName,
      provider.getLatitude,
      provider.getLongitude,
      DateTime.now().toUtc(),
    );
    ComplexZmanimCalendar.intGeoLocation(geoLocation);

    JewishDate jewishDate = JewishDate();
    JewishCalendar jewishCalendar = JewishCalendar();
    ComplexZmanimCalendar complexZmanimCalendar = ComplexZmanimCalendar()
      ..setGeoLocation(geoLocation);
    HebrewDateFormatter translatedDateFormatter = HebrewDateFormatter()
      ..hebrewFormat = false;
    //Store date in provider
    var addedDay = provider.addedDays;
    if (addedDay > 0) {
      jewishCalendar.setDate(DateTime.now().add(Duration(days: addedDay)));
      jewishDate.setDate(DateTime.now().add(Duration(days: addedDay)));
    }
    var todaysHebrewDate = translatedDateFormatter.format(jewishDate);
    var gregorianDate = DateFormat.yMMMd().format(DateTime.now());
    //provider.updateLocation(locationName);
    provider.updateTodaysDate("$gregorianDate | $todaysHebrewDate");

    //Store events
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
      events.add(
        "It's Erev Shabbath ${parasha}, prepare to welcome the bride.",
      );
    }
    if (events.isEmpty) {
      events.add(
          "No special event today – take a moment for personal reflection.");
    }
    provider.updateEventList(events);

    //Store lightingTime
    var startTime = complexZmanimCalendar.getShabbosStartTime();
    var endTime = complexZmanimCalendar.getShabbosExitTime();
    var lightingTime =
        '${DateFormat.E().addPattern('jm').format(startTime)} - ${DateFormat.E().addPattern('jm').format(endTime)}';

    var weeklyParasha = parashot.where((x) => x.name.contains(parasha)).first;
    provider.updateLightingTime(lightingTime);
    provider.updateParasha(weeklyParasha);
  }

  Future<String> getVersionFromPubspec(BuildContext context) async {
    final String pubspecYaml = await rootBundle.loadString(
      'pubspec.yaml',
    );
    final Map<dynamic, dynamic> yamlMap = loadYaml(
      pubspecYaml,
    );
    return yamlMap['version'];
  }
}
