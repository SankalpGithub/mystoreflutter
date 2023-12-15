import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mystore/models/colors.dart';
import 'package:mystore/pages/home.dart';
import 'package:mystore/pages/splash.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyStore',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: my_bg)
      ),
      home: splash(),
    );
  }
}