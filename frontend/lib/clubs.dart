import 'package:flutter/material.dart';
import 'alexa.dart';  // Import AlexaPage
import 'gdsc.dart';  // Import GDSCPage
import 'kzilla.dart';  // Import KzillaPage
import 'auv.dart';  // Import AUVPage
import 'race.dart';  // Import RacePage
import 'events.dart';  // Import EventsPage

class ClubsPage extends StatefulWidget {
  @override
  _ClubsPageState createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ClubsContent(),
    EventsPage(), // Use EventsPage here
    ChatbotContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campus Pulse'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'John Doe', // Replace with actual name
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to About Us page
              },
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to Feedback page
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Clubs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chatbot',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class ClubsContent extends StatefulWidget {
  @override
  _ClubsContentState createState() => _ClubsContentState();
}

class _ClubsContentState extends State<ClubsContent> {
  String _selectedFilter = 'All';

  final List<Map<String, String>> clubs = [
    {
      'name': 'AlexaDevelopers',
      'image': 'assets/images/alexa.png',
      'description': 'Powered by Amazon Alexa, we form the official Alexa Developers Club in SRMIST. Our Goal is to build a Community of Voice First developers through Alexa Skills Workshops, Events and Many more.',
      'type': 'Technical club',
      'route': '/alexa',
    },
    {
      'name': 'GDSC',
      'image': 'assets/images/gdsc.png',
      'description': 'Google Developer Student Club (GDSC) is a Google Developers program for university students to learn mobile and web development skills.',
      'type': 'Technical club',
      'route': '/gdsc',
    },
    {
      'name': 'SRMKZILLA',
      'image': 'assets/images/kzilla.png',
      'description': 'As a part of Mozilla’s open-source community, our mission is to provide a platform for inquisitive minds by guiding and empowering their aspirations.',
      'type': 'Creative club',
      'route': '/kzilla',
    },
    {
      'name': 'SRMAUV',
      'image': 'assets/images/auv.png',
      'description': 'SRMAUV is an under-graduate student team of SRM Institute of Science and Technology, founded in the year 2013. This team of underwater robotics enthusiasts share our common interest in designing Autonomous Underwater Vehicles.',
      'type': 'Mechanical club',
      'route': '/auv',
    },
    {
      'name': 'AUTOCREED RACING',
      'image': 'assets/images/race.png',
      'description': 'Official Electric go-kart racing team of SRMIST ktr. We work on making electric go karts.',
      'type': 'Mechanical club',
      'route': '/race',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredClubs = _selectedFilter == 'All'
        ? clubs
        : clubs.where((club) => club['type'] == _selectedFilter).toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    '',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 8.0),
                  DropdownButton<String>(
                    value: _selectedFilter,
                    dropdownColor: Colors.grey[800],
                    style: TextStyle(color: Colors.white),
                    items: <String>['All', 'Technical club', 'Creative club', 'Mechanical club']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFilter = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: filteredClubs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, filteredClubs[index]['route']!);
                    },
                    child: ClubCard(
                      name: filteredClubs[index]['name']!,
                      image: filteredClubs[index]['image']!,
                      description: filteredClubs[index]['description']!,
                      type: filteredClubs[index]['type']!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClubCard extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final String type;

  ClubCard({
    required this.name,
    required this.image,
    required this.description,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.grey[200], // Grey background color
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatbotContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Chatbot Page Content'),
    );
  }
}

