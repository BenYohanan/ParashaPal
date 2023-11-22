import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';

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
  String? latitude;
  String? longitude;
  String? locationName;
  String? parasha;
  String? torah;
  String? halfTorah;
  String? britChadahsha;
  String? todaysHebrewDate;
  ProviderService() {
    latitude = "";
    longitude = "";
    locationName = "";
    parasha = "";
    torah = "";
    halfTorah = "";
    britChadahsha = "";
    todaysHebrewDate = "";
    notifyListeners();
  }
  String? get getLatitude => latitude;
  String? get getLongitude => longitude;
  String? get getParasha => parasha;
  String? get getTorah => torah;
  String? get getHaftorah => halfTorah;
  String? get getBritChadasha => britChadahsha;
  String? get getLocationName => locationName;
  String? get getHodaysHebrewDate => todaysHebrewDate;
  void updateLocation(String long, String lat, String name) {
    longitude = long;
    latitude = lat;
    locationName = name;
    notifyListeners();
  }

  void updateParashot(
      String half, String tor, String brit, String par, String date) {
    parasha = par;
    halfTorah = half;
    britChadahsha = brit;
    torah = tor;
    todaysHebrewDate = date;
    notifyListeners();
  }

  void disposeLocation(
    String long,
    String lat,
    String name,
  ) {
    longitude = "";
    latitude = "";
    locationName = "";
    notifyListeners();
  }
}
