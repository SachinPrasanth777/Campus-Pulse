import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AlexaPage extends StatelessWidget {
  final Uri applyUrl = Uri.parse(
    'https://docs.google.com/forms/d/e/1FAIpQLSf4OXBSccE2zxZQqeccKTYxws7uU3ewBsb4wT9G8uczjH_85w/viewform?usp=pp_url',
  );

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alexa Developers Club'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/images/alexa.png'),
              SizedBox(height: 16.0),
              Text(
                'Alexa Developers Club',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Powered by Amazon Alexa, we form the official Alexa Developers Club in SRMIST. Our goal is to build a Community of Voice First developers through Alexa Skills Workshops, Events, and many more.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Open Positions',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              JobListing(
                jobTitle: 'Alexa Skills Developer',
                location: 'Remote',
                applyUrl: applyUrl,
                onLaunch: _launchInBrowser,
              ),
              JobListing(
                jobTitle: 'Voice Interface Designer',
                location: 'United States: San Francisco',
                applyUrl: applyUrl,
                onLaunch: _launchInBrowser,
              ),
              JobListing(
                jobTitle: 'AI/ML Research Intern',
                location: 'India: Bangalore',
                applyUrl: applyUrl,
                onLaunch: _launchInBrowser,
              ),
              SizedBox(height: 16.0),
              buildApplyForJobSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildApplyForJobSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          onTap: () async {
            await _launchInBrowser(applyUrl);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Apply for a Job',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.0),
              Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobListing extends StatelessWidget {
  final String jobTitle;
  final String location;
  final Uri applyUrl;
  final Future<void> Function(Uri) onLaunch;

  const JobListing({
    required this.jobTitle,
    required this.location,
    required this.applyUrl,
    required this.onLaunch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            jobTitle,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            location,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement save functionality
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey.withOpacity(0.4),
                ),
                child: const Text('Save Link'),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () => onLaunch(applyUrl),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Launch in browser'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
