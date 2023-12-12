import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';
import 'package:pocket_siddur/models/parasha.dart';

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
  late String latitude;
  late String longitude;
  late String locationName;
  late List<String> events;
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

  ProviderService() {
    latitude = "";
    longitude = "";
    locationName = "";
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
    notifyListeners();
  }

  String get getLatitude => latitude;
  String get getLongitude => longitude;
  Parasha get getParasha => parasha;
  String get getLocationName => locationName;
  String get getTodaysFormattedDate => todaysFormattedDate;
  String get getLightingTime => lightingTime;
  List<String> get getEvents => events;
  int get getAddedDays => addedDays;

  void updateLocation(String long, String lat, String name) {
    longitude = long;
    latitude = lat;
    locationName = name;
    notifyListeners();
  }

  void updateTodaysDate(String date) {
    todaysFormattedDate = date;
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

  void dispose() {
    // Cleanup resources if necessary
    super.dispose();
  }
}
