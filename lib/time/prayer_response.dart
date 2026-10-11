class PrayerResponse {
  final Timings timings;
  final DateInfo gregorian;
  final DateInfo hijri;

  PrayerResponse({
    required this.timings,
    required this.gregorian,
    required this.hijri,
  });

  factory PrayerResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return PrayerResponse(
      timings: Timings.fromJson(data['timings']),
      gregorian: DateInfo.fromJson(data['date']['gregorian']),
      hijri: DateInfo.fromJson(data['date']['hijri']),
    );
  }
}

class Timings {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  // الـ API أحياناً بيرجع "16:35 (EET)" فناخد الوقت بس
  static String _clean(String time) => time.split(' ').first;

  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      fajr: _clean(json['Fajr']),
      sunrise: _clean(json['Sunrise']),
      dhuhr: _clean(json['Dhuhr']),
      asr: _clean(json['Asr']),
      maghrib: _clean(json['Maghrib']),
      isha: _clean(json['Isha']),
    );
  }
}

class DateInfo {
  final String day;
  final String weekday;
  final String month;
  final String year;

  DateInfo({
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
  });

  factory DateInfo.fromJson(Map<String, dynamic> json) {
    return DateInfo(
      day: json['day'],
      weekday: json['weekday']['en'],
      month: json['month']['en'],
      year: json['year'],
    );
  }
}
