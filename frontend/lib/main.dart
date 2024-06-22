import 'package:alexa_internal/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:alexa_internal/clubs.dart'; // Import ClubsPage
import 'package:alexa_internal/alexa.dart'; // Import AlexaPage
import 'package:alexa_internal/gdsc.dart'; // Import GDSCPage
import 'package:alexa_internal/kzilla.dart'; // Import KzillaPage
import 'package:alexa_internal/auv.dart'; // Import AUVPage
import 'package:alexa_internal/race.dart'; // Import RacePage
import 'package:alexa_internal/events.dart'; // Import EventsPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recruitments App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/clubs': (context)=> ClubsPage(),
        '/alexa': (context) => AlexaPage(),
        '/gdsc': (context) => GDSCPage(),
        '/kzilla': (context) => KzillaPage(),
        '/auv': (context) => AUVPage(),
        '/race': (context) => RacePage(),
        '/events': (context) => EventsPage(),
      },
    );
  }
}
