import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceApp extends StatefulWidget {
  @override
  _PreferenceAppState createState() => _PreferenceAppState();
}

class _PreferenceAppState extends State<PreferenceApp> {
  String _userName = '';
  int _counter = 0;
  late Future<SharedPreferences> _prefs;
  late SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

    Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? '';
      _counter = prefs.getInt('counter') ?? 0;
      print('Counter value $_counter is loaded');
      print('Username value $_userName is loaded');
    });

  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', _userName);
    prefs.setInt('counter', _counter);
    print('Counter value $_counter is saved');
    print('Username value $_userName is saved');
  }

  void _updateUserName(String newName) {
    setState(() {
      _userName = newName;
    });
    _savePreferences();
  }

  void _incrementCounter(double newValue) {
    setState(() {
      _counter = newValue.toInt();
    });
    _savePreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Name: $_userName',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              initialValue: _userName,
              onChanged: (value) {
                _updateUserName(value);
                // setState(() {
                //   _userName = value;
                // });
              },
              decoration: InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Counter $_counter',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: _counter.toDouble(),
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (value) {
                _incrementCounter(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}