import 'package:intl/intl.dart';

String reformatDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  return DateFormat('dd-MM-yyyy').format(dateTime);
}
