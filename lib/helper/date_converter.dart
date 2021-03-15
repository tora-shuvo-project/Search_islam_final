import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String formatDateHHMM(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }
  static String formatDateHHMMAA(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }
  static String formatDateMMDD(DateTime dateTime) {
    return DateFormat('dd-MMM').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateTime);
  }
}
