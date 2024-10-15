import 'package:flutter/material.dart';

import 'package:laboratorio_prueba/models/appprovider.dart';
import 'package:laboratorio_prueba/pages/my_home_page.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';


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

    return ChangeNotifierProvider<AppData>(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData.light(useMaterial3: true),
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    //   //home: const AboutApp(),
    //   //home: const DetailApp()
    //   //home: RecipeListScreen(recipes: recipes),
    // );
  }
}

