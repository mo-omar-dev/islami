import 'package:flutter/material.dart';
import 'package:islami_app/app_styles/app_color.dart';
import 'package:islami_app/app_styles/app_text_styles.dart';
import 'package:islami_app/azkar/azkar_screen.dart';
import 'package:islami_app/provider/prayer_provider.dart';
import 'package:islami_app/time/azkar_card.dart';
import 'package:islami_app/time/prayer_card.dart';
import 'package:islami_app/time/prayer_response.dart';
import 'package:islami_app/time/tab_fillet.dart';
import 'package:provider/provider.dart';

const azkarCategories = [
  ('أذكار الصباح', 'Morning Azkar', 'assets/images/morning_azkar.png'),
  ('أذكار المساء', 'Evening Azkar', 'assets/images/evening_azkar.png'),
  (
    'أذكار بعد السلام من الصلاة المفروضة',
    'After Prayer',
    'assets/images/morning_azkar.png'
  ),
  ('تسابيح', 'Tasbeeh', 'assets/images/evening_azkar.png'),
  ('أذكار النوم', 'Sleep Azkar', 'assets/images/morning_azkar.png'),
  ('أذكار الاستيقاظ', 'Wake-up Azkar', 'assets/images/evening_azkar.png'),
  ('أدعية قرآنية', 'Quranic Duas', 'assets/images/morning_azkar.png'),
  ('أدعية الأنبياء', 'Prophets Duas', 'assets/images/evening_azkar.png'),
];

class TimeTab extends StatelessWidget {
  const TimeTab({super.key});
  static const String routeName = 'Time Tab';

  @override
  Widget build(BuildContext context) {
    final prayerProvider = context.watch<PrayerProvider>();
    final prayerData = prayerProvider.prayerData;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/home_screen_logo.png',
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColor.darkGold,
                borderRadius: BorderRadius.circular(40)),
            child: prayerProvider.isLoading
                ? const SizedBox(
                    height: 200,
                    child: Center(
                        child: CircularProgressIndicator(color: AppColor.gold)),
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
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, left: 16, right: 16),
                                      child: Text(
                                        '${prayerData.gregorian.day} ${prayerData.gregorian.month.substring(0, 3)}\n${prayerData.gregorian.year}',
                                        style: AppTextStyle.bold16white,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: TabFillet(isLeft: true),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 10),
                                  decoration: const BoxDecoration(
                                    color: AppColor.gold,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30)),
                                  ),
                                  child: Text(
                                      'pray time\n${prayerData.gregorian.weekday}',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.bold16white
                                          .copyWith(color: AppColor.darkGold)),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: TabFillet(isLeft: false),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, left: 16, right: 16),
                                      child: Text(
                                        '${prayerData.hijri.day.padLeft(2, '0')} ${hijriMonthsShort[prayerData.hijri.monthNumber - 1]},\n${prayerData.hijri.year}',
                                        style: AppTextStyle.bold16white,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: AppColor.gold,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 12),
                                SizedBox(
                                  height: 110,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: prayerProvider.prayerList.length,
                                    itemBuilder: (context, index) {
                                      final prayer =
                                          prayerProvider.prayerList[index];
                                      return PrayerCard(
                                          name: prayer.key, time: prayer.value);
                                    },
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(width: 24),
                                      Text(
                                        'Next Pray - ${prayerProvider.countdownText}',
                                        style: AppTextStyle.bold16white
                                            .copyWith(color: AppColor.grey),
                                      ),
                                      IconButton(
                                        onPressed: prayerProvider.toggleAdhan,
                                        icon: Icon(
                                          prayerProvider.adhanEnabled
                                              ? Icons.volume_up
                                              : Icons.volume_off,
                                          color: AppColor.darkBrown,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text('Azkar', style: AppTextStyle.bold16white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: azkarCategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final (category, title, image) = azkarCategories[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          AzkarScreen(category: category, title: title),
                    ),
                  ),
                  child: AzkarCard(title: title, imagePath: image),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
