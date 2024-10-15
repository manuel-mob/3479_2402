import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/appprovider.dart';

class Audit extends StatelessWidget {
  final List<String> auditList = [
    'Audit 1',
    'Audit 2',
    'Audit 3',
    'Audit 4',
    'Audit 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Audit Page'),
      ),
      body: Center(
      child: ListView.builder(
        itemCount: context.read<AppData>().actions.length,
        itemBuilder: (context, index) {
        return ListTile(
          title: Text(context.read<AppData>().actions[index]),
        );
        },
      ),
      ),
    );
      
  }
}