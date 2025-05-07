import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/features/dashboard/presentation/widgets/small_stat_widget.dart';
import 'package:transfusio/src/features/dashboard/presentation/widgets/stat_widget.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHelper {
  static Widget homeStatShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      period: const Duration(seconds: 1),
      highlightColor: AppColors.primaryColor.withOpacity(0.3),
      child: const StatWidget(
        title: "",
        value: "",
        icon: FontAwesomeIcons.star,
        bgColor: AppColors.secondaryColor,
      ),
    );
  }

  static Widget homeSmallStatShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      period: const Duration(seconds: 1),
      highlightColor: AppColors.primaryColor.withOpacity(0.3),
      child: const SmallStatWidget(
        title: "",
        value: "",
        icon: FontAwesomeIcons.star,
        bgColor: AppColors.secondaryColor,
      ),
    );
  }

  static Widget homePslRequestShimmer(BuildContext context, {int count = 4}) {
    return ListView.builder(
      itemCount: count,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder:
          (BuildContext context, int index) => Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            period: const Duration(seconds: 1),
            highlightColor: AppColors.primaryColor.withOpacity(0.3),
            child: ListTile(
              leading: const CircleAvatar(radius: 30),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Card(
                      child: Text(
                        "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: const Card(child: Text("")),
              trailing: Visibility(
                visible: true,
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(""),
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
