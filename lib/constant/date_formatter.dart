import 'package:intl/intl.dart';

/// A class containing static methods for date parsing and formatting using the 'intl' package.
///
/// The class includes methods for parsing a date string, getting a suitable
/// formatted date string based on the time difference, and parsing and
/// formatting a date string into a specific format.
abstract class DateFormatter {
  static String formatDateTimeToNormalDate(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm');
    final formattedDate = formatter.format(dateTime);
    return formattedDate;
  }


  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy');
    final formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  /// Parse a date string and return a DateTime object.
  static DateTime parseDate(String dateStr) {
    return DateTime.parse(dateStr);
  }

  /// Get a suitable formatted date string based on the time difference between the given date and the current time.
  static String getSuitableDateString(String date, bool showFullDateHours) {
    final now = DateTime.now();
    final parsedDate = DateTime.parse(date);

    final difference = now.difference(parsedDate);

    if (difference.inDays >= 30 && showFullDateHours) {
      final formattedDate = DateFormat('d MMM yyyy, HH:mm').format(parsedDate);

      return formattedDate;
    } else if (difference.inDays >= 30 && !showFullDateHours) {
      final formattedDate = DateFormat('d MMM yyyy').format(parsedDate);

      return formattedDate;
    } else if (difference.inDays >= 1) {
      final daysAgo = difference.inDays;
      return '$daysAgo ${daysAgo == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours >= 1) {
      final hoursAgo = difference.inHours;
      return '$hoursAgo ${hoursAgo == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes >= 1) {
      final minutesAgo = difference.inMinutes;
      return '$minutesAgo ${minutesAgo == 1 ? 'min' : 'mins'} ago';
    } else {
      return 'Just now';
    }
  }

  /// Parse and format a date string into a specific format.
  static String parsedAndFormattedDate(String date) {
    final parsedDate = DateTime.parse(date);
    final formattedDate = DateFormat('d MMM yyyy').format(parsedDate);
    return formattedDate;
  }
}