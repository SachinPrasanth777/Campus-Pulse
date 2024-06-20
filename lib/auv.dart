// auv.dart

import 'package:flutter/material.dart';

class AUVPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SRMAUV'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/auv.png'),
            SizedBox(height: 16.0),
            Text(
              'SRMAUV',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'SRMAUV is an under-graduate student team of SRM Institute of Science and Technology, founded in the year 2013. This team of underwater robotics enthusiasts share our common interest in designing Autonomous Underwater Vehicles.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
