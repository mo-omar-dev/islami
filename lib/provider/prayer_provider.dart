import 'package:flutter/material.dart';
import 'package:islami_app/api_manager/api_manager_prayer.dart';
import 'package:islami_app/time/prayer_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerProvider extends ChangeNotifier {
  PrayerResponse? prayerData;
  bool isLoading = false;
  bool adhanEnabled = false;

  PrayerProvider() {
    _loadAdhanSetting();
  }

  Future<void> _loadAdhanSetting() async {
    final prefs = await SharedPreferences.getInstance();
    adhanEnabled = prefs.getBool('adhan_enabled') ?? false;
    notifyListeners();
  }

  Future<void> toggleAdhan() async {
    adhanEnabled = !adhanEnabled;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('adhan_enabled', adhanEnabled);
  }

  String? errorMessage;
  List<MapEntry<String, String>> get prayerList {
    final t = prayerData?.timings;
    if (t == null) return [];
    return [
      MapEntry('Fajr', _to12h(t.fajr)),
      MapEntry('Sunrise', _to12h(t.sunrise)),
      MapEntry('Dhuhr', _to12h(t.dhuhr)),
      MapEntry('Asr', _to12h(t.asr)),
      MapEntry('Maghrib', _to12h(t.maghrib)),
      MapEntry('Isha', _to12h(t.isha)),
    ];
  }

  String _to12h(String time24) {
    final parts = time24.split(':');
    int hour = int.parse(parts[0]);
    final minute = parts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12 == 0 ? 12 : hour % 12;
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  DateTime _toDateTime(String time24) {
    final parts = time24.split(':');
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
  }

  MapEntry<String, DateTime>? get nextPrayer {
    final t = prayerData?.timings;
    if (t == null) return null;

    final now = DateTime.now();
    final prayers = {
      'Fajr': _toDateTime(t.fajr),
      'Dhuhr': _toDateTime(t.dhuhr),
      'Asr': _toDateTime(t.asr),
      'Maghrib': _toDateTime(t.maghrib),
      'Isha': _toDateTime(t.isha),
    };

    for (final entry in prayers.entries) {
      if (entry.value.isAfter(now)) return entry;
    }

    // كل صلوات النهاردة عدّت، فالجاية هي فجر بكرة
    return MapEntry('Fajr', prayers['Fajr']!.add(const Duration(days: 1)));
  }

  Duration get timeUntilNext {
    final next = nextPrayer;
    if (next == null) return Duration.zero;
    return next.value.difference(DateTime.now());
  }

  String get countdownText {
    final d = timeUntilNext;
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  Future<void> loadPrayerTimes() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      prayerData = await ApiManagerPrayer.getData();
    } catch (e) {
      errorMessage = 'مش قادر أحمّل المواقيت، تأكد من النت';
    }

    isLoading = false;
    notifyListeners();
  }
}
