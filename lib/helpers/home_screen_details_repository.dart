import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_siddur/models/parasha.dart';

import '../models/userLocation.dart';

class ProviderService extends ChangeNotifier {
  List<String> events = [];
  String location = "";
  Parasha parasha = Parasha(
    name: '',
    torah: '',
    haftarah: '',
    britChadashah: '',
    summary: '',
  );
  var _userCUrrentLocation = UserLocation(
    locationName: '',
    longitude: 0,
    latitude: 0,
  );
  var prayerTime = PrayerTime(
    minchaGdola: '',
    minchaKtana: '',
    shemaMorning: '',
    shemaEvening: '',
  );
  String lightingTime = "";
  String todaysFormattedDate = "";
  int addedDays = 0;
  String? version;
  String? playStoreVersion;
  var verseOfTheDay = VerseOfTheDay(
    message: '',
    verse: '',
    date: DateTime.parse('2023-01-01'),
  );

  Parasha get getParasha => parasha;
  UserLocation get getUserLocation => _userCUrrentLocation;
  String get getTodaysFormattedDate => todaysFormattedDate;
  String get getLightingTime => lightingTime;
  List<String> get getEvents => events;
  int get getAddedDays => addedDays;
  String? get getAppVersion => version;
  String? get getPlayStoreAppVersion => playStoreVersion;
  PrayerTime get getPrayerTimes => prayerTime;
  VerseOfTheDay get getVerseOfTheDay => verseOfTheDay;

  void updateLocation(UserLocation location) async {
    final box = Hive.box('pocket_siddur');
    _userCUrrentLocation = location;
    await box.put(
      'userLocation',
      location.toJson(),
    );
    notifyListeners();
  }

  void updateDailyVerse(VerseOfTheDay todaysVerse) async {
    final box = Hive.box('pocket_siddur');
    verseOfTheDay = todaysVerse;
    await box.put(
      'todaysVerse',
      verseOfTheDay.toJson(),
    );
    notifyListeners();
  }

  void updatePrayerTime(PrayerTime prayerNotification) async {
    final box = Hive.box('pocket_siddur');
    prayerTime = prayerNotification;
    await box.put(
      'prayerTime',
      prayerTime.toJson(),
    );
    notifyListeners();
  }

  void updateTodaysDate(String date) async {
    final box = Hive.box('pocket_siddur');
    todaysFormattedDate = date;
    await box.put(
      'todaysFormattedDate',
      date,
    );
    notifyListeners();
  }

  void updateLightingTime(String time) async {
    final box = Hive.box('pocket_siddur');
    lightingTime = time;
    await box.put(
      'lightingTime',
      time,
    );
    notifyListeners();
  }

  void updateParasha(Parasha parashaOfTheWeek) async {
    final box = Hive.box('pocket_siddur');
    parasha = parashaOfTheWeek;
    await box.put(
      'parashaOfTheWeek',
      parashaOfTheWeek.toJson(),
    );
    notifyListeners();
  }

  void updateEventList(List<String> todaysEvents) async {
    final box = Hive.box('pocket_siddur');
    events = todaysEvents;
    await box.put(
      'events',
      events,
    );
    notifyListeners();
  }

  void incrementAddedDays(int daysAdded) {
    addedDays += daysAdded;
    notifyListeners();
  }

  void decrementAddedDays(int daysAdded) {
    if (addedDays != 0) {
      addedDays -= daysAdded;
      notifyListeners();
    }
  }

  void updateAppVersion(String appVersion) {
    version = appVersion;
    notifyListeners();
  }
}
