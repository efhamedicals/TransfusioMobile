import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/core/utils/helpers/shimmer_helper.dart';
import 'package:transfusio/src/features/notifications/presentation/view_models/notification_view_model.dart';
import 'package:transfusio/src/features/notifications/presentation/widgets/notification_widget.dart';
import 'package:transfusio/src/shared/presentation/widgets/app_bars/simple_app_bar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotificationViewModel notificationViewModel =
      locator<NotificationViewModel>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notificationViewModel.getNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Notifications"),
      body: Obx(
        () =>
            notificationViewModel.isLoading.isTrue
                ? ShimmerHelper.homePslRequestShimmer(context, count: 10)
                : notificationViewModel.notifications.isNotEmpty
                ? RefreshIndicator(
                  onRefresh: () {
                    notificationViewModel.getNotifications();
                    return Future.value();
                  },
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: notificationViewModel.notifications.length,
                    separatorBuilder:
                        (context, index) => Dimensions.verticalSpacer(10),
                    itemBuilder:
                        (context, index) => NotificationWidget(
                          notificationModel:
                              notificationViewModel.notifications[index],
                        ),
                  ),
                )
                : const Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text("Aucune notification trouvée"),
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
