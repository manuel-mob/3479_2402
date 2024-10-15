import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Card Sample')),
        body: Center(child: Column(
          children: [
            const Text("About"),
            Image.network(
    'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif')
          ],
        )),
      ),
    );
  }
}
