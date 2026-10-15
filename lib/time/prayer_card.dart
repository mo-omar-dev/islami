import 'package:flutter/material.dart';
import 'package:islami_app/app_styles/app_color.dart';
import 'package:islami_app/app_styles/app_text_styles.dart';

class PrayerCard extends StatelessWidget {
  final String name;
  final String time; // مثال: "04:38 PM"

  const PrayerCard({super.key, required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    final parts = time.split(' '); // ["04:38", "PM"]
    return Container(
      width: 90,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.darkBrown, AppColor.lightBrown],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: AppTextStyle.bold16white),
          const SizedBox(height: 6),
          Text(parts[0],
              style: AppTextStyle.bold16white.copyWith(fontSize: 24)),
          Text(parts[1],
              style: AppTextStyle.bold16white.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
