import 'package:flutter/material.dart';
import 'package:islami_app/app_styles/app_color.dart';

class TabFillet extends StatelessWidget {
  final bool isLeft;
  const TabFillet({super.key, required this.isLeft});

  static const double size = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: AppColor.gold,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.darkGold,
          borderRadius: BorderRadius.only(
            bottomRight: isLeft ? const Radius.circular(size) : Radius.zero,
            bottomLeft: isLeft ? Radius.zero : const Radius.circular(size),
          ),
        ),
      ),
    );
  }
}
