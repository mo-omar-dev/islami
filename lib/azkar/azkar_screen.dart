import 'package:flutter/material.dart';
import 'package:islami_app/app_styles/app_color.dart';
import 'package:islami_app/azkar/azkar_loader.dart';
import 'package:islami_app/azkar/zikr.dart';
import 'package:islami_app/azkar/zikr_tile.dart';

class AzkarScreen extends StatefulWidget {
  final String category; // مفتاح القسم في ملف الـ JSON
  final String title;
  const AzkarScreen({super.key, required this.category, required this.title});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  late Future<Map<String, List<Zikr>>> _future;

  @override
  void initState() {
    super.initState();
    _future = AzkarLoader.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBrown,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColor.darkBrown,
        foregroundColor: AppColor.gold,
      ),
      body: FutureBuilder<Map<String, List<Zikr>>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
                child: CircularProgressIndicator(color: AppColor.gold));
          }
          if (snapshot.hasError) {
            return const Center(child: Text('مش قادر أحمّل الأذكار'));
          }
          final list = snapshot.data![widget.category] ?? [];
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) => ZikrTile(zikr: list[index]),
          );
        },
      ),
    );
  }
}
