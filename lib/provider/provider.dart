import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';
import 'package:pocket_siddur/models/parasha.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  Location location = Location();
  late LocationData _locData;

  Future<void> initialize() async {
    bool serviceEnabled;
    PermissionStatus permission;
    LocationAccuracy.high;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<LocationData> getPosition() async {
    _locData = await location.getLocation();
    return _locData;
  }
}

Future<bool?> getReligiousChoiceValue() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool('isMessianic');
}

Future<bool> IsMessianic(bool value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.setBool('isMessianic', value);
}

class GetStoredDataFromSharedPreference {
  final storage = const FlutterSecureStorage();
  Future<String?> getStoredData(String key) async {
    return await storage.read(key: key);
  }

  Future<void> storeData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<void> deleteDataByKey(String key) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAllStoredData(String key) async {
    await storage.deleteAll();
  }
}

class ProviderService extends ChangeNotifier {
  late String locationName;
  late double longitude;
  late double latitude;
  late List<String> events;
  late String location = "";
  late Parasha parasha = Parasha(
    name: '',
    torah: '',
    haftarah: '',
    britChadashah: '',
    summary: '',
  );
  late String lightingTime = "";
  late String todaysFormattedDate = "";
  int addedDays = 0;
  String? version;
  String? playStoreVersion;

  ProviderService() {
    locationName = "";
    longitude = 0.0;
    latitude = 0.0;
    location = "";
    parasha = Parasha(
      name: "",
      torah: "",
      haftarah: "",
      britChadashah: "",
      summary: "",
    );
    events = [];
    lightingTime = "";
    todaysFormattedDate = "";
    addedDays = 0;
    version = "";
    playStoreVersion = "1.0.0+1";
    notifyListeners();
  }

  Parasha get getParasha => parasha;
  String get getLocationName => locationName;
  double get getLatitude => latitude;
  double get getLongitude => longitude;
  String get getTodaysFormattedDate => todaysFormattedDate;
  String get getLightingTime => lightingTime;
  List<String> get getEvents => events;
  int get getAddedDays => addedDays;
  String? get getAppVersion => version;
  String? get getPlayStoreAppVersion => playStoreVersion;

  void updateLocation(String name, double lat, double long) {
    locationName = name;
    longitude = lat;
    longitude = long;
    notifyListeners();
  }

  void updateTodaysDate(String date) {
    todaysFormattedDate = date;
    notifyListeners();
  }

  void updateLightingTime(String time) {
    lightingTime = time;
    notifyListeners();
  }

  void updateParasha(Parasha parashaOfTheWeek) {
    parasha = parashaOfTheWeek;
    notifyListeners();
  }

  void updateEventList(List<String> todaysEvents) {
    events = todaysEvents;
    notifyListeners();
  }

  void incrementAddedDays(int daysAdded) {
    addedDays += daysAdded;
    notifyListeners();
  }

  void decrementAddedDays(int daysAdded) {
    addedDays -= daysAdded;
    notifyListeners();
  }

  void updateAppVersion(String appVersion) {
    version = appVersion;
    notifyListeners();
  }

  void dispose() {
    // Cleanup resources if necessary
    super.dispose();
  }
}
