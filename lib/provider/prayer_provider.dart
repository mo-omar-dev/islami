import 'package:flutter/material.dart';
import 'package:islami_app/api_manager/api_manager_prayer.dart';
import 'package:islami_app/time/prayer_response.dart';

class PrayerProvider extends ChangeNotifier {
  PrayerResponse? prayerData;
  bool isLoading = false;
  String? errorMessage;

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
