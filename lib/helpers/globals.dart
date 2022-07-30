// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:intl/intl.dart';

class Globals {
  static formatDate(String? s) {
    if(s == null)
      return "Tarih yok";
    var now = DateFormat('yyyy-MM-dd HH:mm:ss').parse(s.replaceAll('T', ' '));

    var day = now.day.toString().length == 1 ? "0${now.day}" : now.day;
    String convertedDateTime = "$day.${now.month.toString().padLeft(2,'0')}.${now.year.toString()}";
    return convertedDateTime;

  }
  static formatDateWithHour(String? s) {
    if(s == null)
      return "Tarih yok";
    var now = DateFormat('yyyy-MM-dd HH:mm:ss').parse(s.replaceAll('T', ' '));

    var day = now.day.toString().length == 1 ? "0${now.day}" : now.day;
    String convertedDateTime = "$day.${now.month.toString().padLeft(2,'0')}.${now.year.toString()}";
    return convertedDateTime;

  }
}