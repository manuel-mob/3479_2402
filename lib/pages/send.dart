import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SendPage extends StatelessWidget {
  final TextEditingController input1Controller = TextEditingController();
  final TextEditingController input2Controller = TextEditingController();

  void _submitForm(BuildContext context) {
    String input1 = input1Controller.text;
    String input2 = input2Controller.text;

    String emailSubject = 'Sending Email';
    String emailBody = 'Input 1: $input1\nInput 2: $input2\n\nThis is the body of the email message.';

    Share.share(emailBody, subject: emailSubject);

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'srasti.verma@coditas.com',
      queryParameters: <String, String>{
        'subject': emailSubject,
        'body': emailBody,
      },
    );
    Share.shareUri(emailUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: input1Controller,
              decoration: InputDecoration(
                labelText: 'Input 1',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: input2Controller,
              decoration: InputDecoration(
                labelText: 'Input 2',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _submitForm(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}