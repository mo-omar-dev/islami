import 'package:flutter/material.dart';
import 'package:islami_app/app_styles/app_color.dart';
import 'package:islami_app/app_styles/app_text_styles.dart';

class AzkarCard extends StatelessWidget {
  final String title;
  final String? imagePath;

  const AzkarCard({super.key, required this.title, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.darkBrown,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColor.gold, width: 2),
        ),
        child: Column(
          children: [
            Expanded(
              child: imagePath == null
                  ? const Icon(Icons.menu_book_rounded,
                      size: 64, color: AppColor.gold)
                  : Image.asset(imagePath!, fit: BoxFit.contain),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyle.bold16white.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
