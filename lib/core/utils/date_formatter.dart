import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy - hh:mm a').format(dateTime);
  }

  static String formatDateOnly(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  static String formatTimeOnly(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  static DateTime parseDateTime(String dateTimeStr) {
    return DateFormat('MMM dd, yyyy - hh:mm a').parse(dateTimeStr);
  }

  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}