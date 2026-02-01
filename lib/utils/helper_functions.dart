import 'package:intl/intl.dart';

String getFormttedDateTime (num dt,[String pattern ='yyyy-MM-dd'])=>
DateFormat.E(pattern).format(DateTime.fromMillisecondsSinceEpoch(dt.toInt()));