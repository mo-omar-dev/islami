import 'package:flutter/material.dart';
import 'package:islami_app/app_styles/app_color.dart';
import 'package:islami_app/app_styles/app_text_styles.dart';
import 'package:islami_app/azkar/zikr.dart';

class ZikrTile extends StatefulWidget {
  final Zikr zikr;
  const ZikrTile({super.key, required this.zikr});

  @override
  State<ZikrTile> createState() => _ZikrTileState();
}

class _ZikrTileState extends State<ZikrTile> {
  late int remaining = widget.zikr.count;

  void _onTap() {
    if (remaining > 0) setState(() => remaining--);
  }

  @override
  Widget build(BuildContext context) {
    final done = remaining == 0;
    return GestureDetector(
      onTap: _onTap,
      child: Opacity(
        opacity: done ? 0.5 : 1,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.grey,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColor.gold),
          ),
          child: Column(
            children: [
              Text(
                widget.zikr.content,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: AppTextStyle.bold16white.copyWith(height: 1.8),
              ),
              if (widget.zikr.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  widget.zikr.description,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyle.bold16DarkGold.copyWith(fontSize: 14),
                ),
              ],
              const SizedBox(height: 12),
              Text(
                done ? '✓' : '$remaining',
                style: AppTextStyle.bold16DarkGold.copyWith(fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
