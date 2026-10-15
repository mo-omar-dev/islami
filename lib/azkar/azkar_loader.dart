import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:islami_app/azkar/zikr.dart';

class AzkarLoader {
  static Future<Map<String, List<Zikr>>> load() async {
    final text = await rootBundle.loadString('assets/files/azkar/azkar.json');
    final Map<String, dynamic> json = jsonDecode(text);
    return json.map<String, List<Zikr>>(
      (category, items) => MapEntry(category, _flatten(items)),
    );
  }

  static List<Zikr> _flatten(dynamic items) {
    final result = <Zikr>[];
    for (final item in items) {
      if (item is List) {
        result.addAll(_flatten(item));
      } else if (item['category'] != 'stop') {
        result.add(Zikr.fromJson(item));
      }
    }
    return result;
  }
}
