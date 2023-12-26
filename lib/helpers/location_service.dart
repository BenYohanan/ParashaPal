
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';

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

