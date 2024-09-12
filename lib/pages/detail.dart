import 'package:flutter/material.dart';

class DetailApp extends StatelessWidget {
  const DetailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('X / O')),
        body: Center (
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                        ),
                        child: const Text('...'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                        ),
                        child: const Text('...'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                        ),
                        child: const Text('...'),
                  ),
                ],
              ),
              Row(children: [],
              ),
              Row(children: [],
              )
            ],
          ),
          ) 
      ),
    );
  }
}
