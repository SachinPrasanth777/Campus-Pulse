// kzilla.dart

import 'package:flutter/material.dart';

class KzillaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SRMKZILLA'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/kzilla.png'),
            SizedBox(height: 16.0),
            Text(
              'SRMKZILLA',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'As a part of Mozilla’s open-source community, our mission is to provide a platform for inquisitive minds by guiding and empowering their aspirations.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
