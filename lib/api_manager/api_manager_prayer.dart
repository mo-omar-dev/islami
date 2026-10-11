import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:islami_app/time/prayer_response.dart';

class ApiManagerPrayer {
  static Future<PrayerResponse> getData() async {
    Uri uri = Uri.parse(
        'https://api.aladhan.com/v1/timingsByCity?city=Cairo&country=Egypt&method=5');
    var response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to load prayer times (${response.statusCode})');
    }
    var json = jsonDecode(response.body);
    return PrayerResponse.fromJson(json);
  }
}
