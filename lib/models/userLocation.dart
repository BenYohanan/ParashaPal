import 'dart:convert';

class UserLocation {
  String? locationName;
  double? longitude;
  double? latitude;

  UserLocation({
    this.locationName,
    this.longitude,
    this.latitude,
  });
  Map<String, dynamic> toMap() {
    return {
      'locationName': locationName,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    return UserLocation(
      locationName: map['locationName'],
      longitude: map['longitude'],
      latitude: map['latitude'],
    );
  }
  String toJson() => json.encode(toMap());
  factory UserLocation.fromJson(String source) =>
      UserLocation.fromMap(json.decode(source));
}

class PrayerTime {
  String? minchaGdola;
  String? minchaKtana;
  String? shemaMorning;
  String? shemaEvening;

  PrayerTime({
    this.minchaGdola,
    this.minchaKtana,
    this.shemaMorning,
    this.shemaEvening,
  });
  Map<String, dynamic> toMap() {
    return {
      'minchaGdola': minchaGdola,
      'minchaKtana': minchaKtana,
      'shemaMorning': shemaMorning,
      'shemaEvening': shemaEvening,
    };
  }

  factory PrayerTime.fromMap(Map<String, dynamic> map) {
    return PrayerTime(
      minchaGdola: map['minchaGdola'],
      minchaKtana: map['minchaKtana'],
      shemaMorning: map['shemaMorning'],
      shemaEvening: map['shemaEvening'],
    );
  }
  String toJson() => json.encode(toMap());
  factory PrayerTime.fromJson(String source) =>
      PrayerTime.fromMap(json.decode(source));
}

class VerseOfTheDay {
  String? verse;
  String? message;
  DateTime? date;

  VerseOfTheDay({
    this.verse,
    this.message,
    this.date,
  });
  Map<String, dynamic> toMap() {
    return {
      'verse': verse,
      'message': message,
      'date': date,
    };
  }

  factory VerseOfTheDay.fromMap(Map<String, dynamic> map) {
    return VerseOfTheDay(
      verse: map['verse'],
      message: map['message'],
      date: map['date'],
    );
  }
  String toJson() => json.encode(toMap());
  factory VerseOfTheDay.fromJson(String source) =>
      VerseOfTheDay.fromMap(json.decode(source));
}
