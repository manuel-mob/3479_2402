import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laboratorio_prueba/pages/about.dart';
import 'package:laboratorio_prueba/pages/detail.dart';
import 'package:laboratorio_prueba/pages/my_home_page.dart';
import 'package:logger/logger.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    logger.d("Logger is working!");

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //home: const AboutApp(),
      home: const DetailApp()
    );
  }
}

