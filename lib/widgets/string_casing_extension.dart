import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

String formatDate(String dateTimeStr) {
  DateTime dateTime = DateTime.parse(dateTimeStr);
  String formattedDate = DateFormat('d MMM yyyy').format(dateTime);
  return formattedDate;
}
