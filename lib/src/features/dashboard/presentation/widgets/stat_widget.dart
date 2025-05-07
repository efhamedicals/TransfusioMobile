import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color bgColor;
  final Widget? child;

  const StatWidget(
      {super.key,
      required this.title,
      required this.value,
      required this.icon,
      required this.bgColor,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            icon,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith()),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 40, fontWeight: FontWeight.bold)),
              child != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: child!,
                    )
                  : const Center()
            ],
          )
        ],
      ),
    );
  }
}
