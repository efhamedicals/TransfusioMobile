import 'package:intl/intl.dart';

class DateHelper {
  static String convertToDateTimeString(String date) {
    DateTime dateTime = DateTime.parse(date);

    String formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);

    return formattedDate;
  }

  static bool isOlderThanMinutes(String date, int minutes) {
    DateTime createdAt = DateTime.parse(date);
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inMinutes > minutes;
  }
}
