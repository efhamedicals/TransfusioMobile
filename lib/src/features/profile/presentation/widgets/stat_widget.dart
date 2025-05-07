import 'package:flutter/material.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';

class StatWidget extends StatelessWidget {
  final String title;
  final String value;
  const StatWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.placeholderBg2,
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
