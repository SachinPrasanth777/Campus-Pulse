import 'package:alexa_internal/clubs.dart';
import 'package:flutter/material.dart';
import 'package:alexa_internal/recruitements.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'), // Replace with your image path
            fit: BoxFit.cover, // Adjust the image fitting as needed
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Campus Pulse',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 55.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'By ByteBrigade',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 80.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Recruitments
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClubsPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6E8CB6), // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Button border radius
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
