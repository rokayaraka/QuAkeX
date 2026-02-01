import 'package:earthquake_app/myApp.dart';
import 'package:earthquake_app/providers/app_data_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  //await initializeDateFormatting("en", "");
  runApp(ChangeNotifierProvider(
      create: (context) => AppDataProvider(),
    child: const MyApp()));
}

