// gdsc.dart

import 'package:flutter/material.dart';

class GDSCPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Developer Student Club (GDSC)'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/gdsc.png'),
            SizedBox(height: 16.0),
            Text(
              'Google Developer Student Club (GDSC)',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Google Developer Student Club (GDSC) is a Google Developers program for university students to learn mobile and web development skills.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
