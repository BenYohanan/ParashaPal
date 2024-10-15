import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:kosher_dart/kosher_dart.dart';
import 'package:pocket_siddur/helpers/helpers.dart';
import 'package:pocket_siddur/helpers/home_screen_details.dart';
import 'package:pocket_siddur/models/parasha.dart';
import 'package:pocket_siddur/models/userLocation.dart';
import '../../helpers/location_service.dart';
import '../../size_config.dart';
import 'intro_page.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    initializeCalendar();
    controller = AnimationController(
      duration: Duration(
        milliseconds: 10000,
      ),
      vsync: this,
    );
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);

    // Move the addListener logic to initState
    opacity.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    controller.forward().then((_) {
      if (mounted) {
        navigationPage();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(9, 65, 143, 0.678),
        image: DecorationImage(
          image: AssetImage(
            'assets/micha.png',
          ),
        ),
      ),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Align(
                child: Opacity(
                  opacity: opacity.value,
                  child: Image.asset(
                    'assets/logo.png',
                    height: getProportionateScreenHeight(200),
                    width: getProportionateScreenHeight(200),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                getProportionateScreenHeight(
                  2,
                ),
              ),
              child: RichText(
                text: TextSpan(
                  text: 'Techiya',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> initializeCalendar() async {
    try {
      await getLocation();
      await updateHomeScreenDetails();
    } catch (e, stackTrace) {
      print('Error initializing calendar: $e\n$stackTrace');
      await getLocation();
    }
  }

  updateHomeScreenDetails() {
    var provider = ref.read(providerServiceProvider.notifier);
    GeoLocation geoLocation = GeoLocation.setLocation(
      provider.getUserLocation.locationName!,
      provider.getUserLocation.latitude!,
      provider.getUserLocation.longitude!,
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

    var dayOfMonth = jewishDate.getJewishDayOfMonth();
    var month = jewishDate.getJewishMonth();

    if (month == 7) {
      if (dayOfMonth >= 11 && dayOfMonth <= 21) {
        // Immediately after yom kippur to the week of Sukkot (from 15th to 21st of Tishrei)
        provider.updateParasha(Parasha(
          name: 'Sukkot',
          torah: '',
          haftarah: '',
          britChadashah: '',
          summary: '',
        ));
      }
    } else if (month == 1) {
      if (dayOfMonth >= 15 && dayOfMonth <= 21) {
        // If it's the week of Pesach (from 15th to 21st of Abib)
        provider.updateParasha(Parasha(
          name: 'Pesach',
          torah: '',
          haftarah: '',
          britChadashah: '',
          summary: '',
        ));
      }
    } else {
      // If it's not during Sukkot or Pesach, update with the regular weekly Parasha
      var weeklyParasha = parashot.where((x) => x.name.contains(parasha)).first;
      provider.updateParasha(weeklyParasha);
    }
    provider.updateLightingTime(lightingTime);

    //Get and update verse of the day
    List<String> _verses = Helper().bibleVerses;
    Random random = Random();
    var today = DateTime.now();
    String contentOfVerse = _verses[random.nextInt(
      _verses.length,
    )];
    List<String> parts = contentOfVerse.split('(');
    String reference = parts.length > 1 ? parts[1].replaceAll(')', '') : '';
    var verseModel = VerseOfTheDay(
      message: parts[0],
      verse: reference,
      date: today,
    );
    provider.updateDailyVerse(verseModel);
  }

  Future<void> getLocation() async {
    try {
      var location = await LocationService().getPosition();

      // Check if the widget is still mounted before updating the state
      if (mounted) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          location.latitude!,
          location.longitude!,
        );
        if (placemarks != null && placemarks.isNotEmpty) {
          Placemark first = placemarks.first;
          String locationName =
              "${first.administrativeArea}, ${first.locality}, ${first.country}";
          var userLocation = UserLocation(
            locationName: locationName,
            latitude: location.latitude,
            longitude: location.longitude,
          );
          ref.read(providerServiceProvider.notifier).updateLocation(
                userLocation,
              );
        }
      }
    } catch (e) {
      // Handle exceptions if necessary
      print('Error getting location: $e');
    }
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => IntroPage(),
      ),
    );
  }
}
