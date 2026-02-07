import 'package:earthquake_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.greenAccent.shade100,
      ),

      builder: EasyLoading.init(),
      home: const HomePage(),
    );
  }
}