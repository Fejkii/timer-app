import 'package:intl/intl.dart';

String appFormatDateTime(DateTime dateTime) {
  return DateFormat.yMMMd().add_Hms().format(dateTime);
}

String appFormatDoubleToString(double number) {
  return number.toStringAsFixed(1);
}

String appFormatDoubleToPercent(double number) {
  return "${appFormatDoubleToString(number * 100)} %";
}
