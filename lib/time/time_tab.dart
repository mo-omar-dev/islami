import 'package:flutter/material.dart';
import 'package:islami_app/app_styles/app_color.dart';
import 'package:islami_app/app_styles/app_text_styles.dart';
import 'package:islami_app/provider/prayer_provider.dart';
import 'package:provider/provider.dart';

class TimeTab extends StatelessWidget {
  const TimeTab({super.key});
  static const String routeName = 'Time Tab';

  @override
  Widget build(BuildContext context) {
    final prayerProvider = context.watch<PrayerProvider>();
    final prayerData = prayerProvider.prayerData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          'assets/images/home_screen_logo.png',
        ),
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColor.grey, borderRadius: BorderRadius.circular(40)),
          child: prayerProvider.isLoading
              ? const SizedBox(
                  height: 200,
                  child: Center(
                      child:
                          CircularProgressIndicator(color: AppColor.darkGold)),
                )
              : prayerData == null
                  ? SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          prayerProvider.errorMessage ?? 'حصل خطأ',
                          style: AppTextStyle.bold16white,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${prayerData.gregorian.day} ${prayerData.gregorian.month}\n${prayerData.gregorian.year}',
                              style: AppTextStyle.bold16white,
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              'pray time\n${prayerData.gregorian.weekday}',
                              style: AppTextStyle.bold16DarkGold,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${prayerData.hijri.day} ${prayerData.hijri.month}\n${prayerData.hijri.year}',
                              style: AppTextStyle.bold16white,
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
        )
      ],
    );
  }
}
