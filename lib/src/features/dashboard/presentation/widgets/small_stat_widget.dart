import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SmallStatWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color bgColor;
  final Widget? child;

  const SmallStatWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.bgColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  child != null
                      ? Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: child!,
                      )
                      : const Center(),
                ],
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: FaIcon(icon, size: 30, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
