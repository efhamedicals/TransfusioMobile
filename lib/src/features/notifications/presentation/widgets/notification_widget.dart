import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transfusio/src/core/utils/helpers/date_helper.dart';
import 'package:transfusio/src/features/notifications/data/models/notification_model.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationWidget({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: ListTile(
          leading:
              (notificationModel.isRead!)
                  ? const FaIcon(FontAwesomeIcons.envelopeOpen)
                  : const FaIcon(FontAwesomeIcons.solidEnvelope),
          title: Text(
            notificationModel.title!,
            style:
                (notificationModel.isRead!)
                    ? const TextStyle()
                    : const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              notificationModel.content!,
              style:
                  (notificationModel.isRead!)
                      ? const TextStyle()
                      : const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          trailing: SizedBox(
            width: 80,
            child: Text(
              DateHelper.convertToDateTimeString(notificationModel.createdAt!),
              style:
                  (notificationModel.isRead!)
                      ? const TextStyle(fontSize: 10)
                      : const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
