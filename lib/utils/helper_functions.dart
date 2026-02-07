import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<String> getFormttedDateTime (num dt,[String pattern ='yyyy-MM-dd'])async{
  await initializeDateFormatting();
return DateFormat(pattern).format(DateTime.fromMillisecondsSinceEpoch(dt.toInt()));
}


void showMsg(BuildContext context,String msg)=>
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));