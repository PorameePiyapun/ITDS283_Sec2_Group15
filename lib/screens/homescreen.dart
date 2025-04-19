import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String pm25 = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchPM25Data();
  }

  Future<void> fetchPM25Data() async {
    final response = await http.get(Uri.parse(
        'https://api.waqi.info/feed/bangkok/?token=66161b4b652e008cce7d3837cbe8a3b6bda709d2'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        pm25 = data['data']['iaqi']['pm25']['v'].toString();
      });
    } else {
      setState(() {
        pm25 = 'Error fetching data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/reservation'); // Navigate to ReservationScreen
          } else if (index == 2) {
            Navigator.pushNamed(context, '/browse'); // Navigate to BrowseScreen
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.event_note), label: "Reservation"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Browse"),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Home",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF3cc4b4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(Icons.cloud, color: Colors.white),
                    SizedBox(width: 10),
                    Text("PM2.5", style: TextStyle(color: Colors.white)),
                    Spacer(),
                    Text("Bangkok", style: TextStyle(color: Colors.white70)),
                    SizedBox(width: 10),
                    Text(pm25, style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Text("Steps", style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("20,000", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("/10,000"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Column(children: [Icon(Icons.directions_walk), Text("20,000")]),
                  Column(children: [Icon(Icons.directions_bike), Text("31/60m")]),
                  Column(children: [Icon(Icons.local_fire_department), Text("787/500 cal")]),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(child: Text("Graph Placeholder")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}