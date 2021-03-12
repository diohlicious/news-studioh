import 'package:intl/intl.dart';

class FunctionUtil {
  static bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }
  static String formatDate(DateTime _date) {
    String formattedDate = DateFormat('h:mm a, dd MMM yyyy').format(_date);
    return formattedDate;
  }
}