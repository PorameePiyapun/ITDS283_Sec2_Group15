import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer'; // Import for logging

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String pm25 = 'Loading...';
  List<String> healthNewsTitles = [];
  String newsError = ''; // State variable to hold news fetch errors
  String pm25Error = ''; // State variable to hold PM2.5 fetch errors

  // --- Important: Security Note ---
  // Hardcoding API keys directly in your code is generally not recommended
  // for production applications, especially if the app is distributed.
  // Consider using environment variables or a secure backend to handle keys.
  final String newsApiKey = 'e0f53812738541b8bf0a281ecd7dc7cd'; // Your NewsAPI key
  final String waqiApiKey = '66161b4b652e008cce7d3837cbe8a3b6bda709d2'; // Your Waqi.info key

  @override
  void initState() {
    super.initState();
    fetchPM25Data();
    fetchHealthNews();
  }

  Future<void> fetchPM25Data() async {
    try {
      final uri = Uri.parse('https://api.waqi.info/feed/bangkok/?token=$waqiApiKey');
      final response = await http.get(uri);

      log('Waqi.info Status Code: ${response.statusCode}');
      // log('Waqi.info Response Body: ${response.body}'); // Uncomment for debugging

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Check if the expected data path exists
        if (data['data'] != null && data['data']['iaqi'] != null && data['data']['iaqi']['pm25'] != null && data['data']['iaqi']['pm25']['v'] != null) {
          setState(() {
            pm25 = data['data']['iaqi']['pm25']['v'].toString();
            pm25Error = ''; // Clear any previous error
          });
        } else {
           setState(() {
             pm25 = 'N/A';
             pm25Error = 'PM2.5 data not found in response.';
           });
           log('Waqi.info: PM2.5 data path invalid in response.');
        }
      } else {
        setState(() {
          pm25 = 'Error';
          pm25Error = 'Failed to load PM2.5: Status ${response.statusCode}';
        });
        log('Waqi.info: Failed to load PM2.5 with status: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        pm25 = 'Error';
        pm25Error = 'Exception fetching PM2.5: $e';
      });
      log('Waqi.info: Exception during fetch: $e');
    }
  }

  Future<void> fetchHealthNews() async {
    try {
      // Added country=us parameter. You might want to change 'us' to 'th' for Thailand
      // or another country relevant to your users, depending on NewsAPI coverage.
      final uri = Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=$newsApiKey');
      final response = await http.get(uri);

      log('NewsAPI Status Code: ${response.statusCode}');
      // log('NewsAPI Response Body: ${response.body}'); // Uncomment for debugging

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Check if 'articles' list is present and not null
        if (data['articles'] != null && data['articles'] is List) {
           setState(() {
             // Use `where` to filter out potential null titles if needed, although `?? 'No title'` handles it
             healthNewsTitles = (data['articles'] as List)
                 .take(7) // Take up to the first 7 articles
                 .map<String>((article) {
                   // Safely access title, provide fallback
                   return article['title']?.toString() ?? 'No title available';
                 })
                 .toList();
              newsError = ''; // Clear any previous error
              if (healthNewsTitles.isEmpty) {
                 newsError = 'No health news found.';
                 log('NewsAPI: Received 200 but no articles found.');
              }
           });
        } else {
           setState(() {
             healthNewsTitles = [];
             newsError = 'News articles not found in response.';
           });
           log('NewsAPI: "articles" key not found or not a list in response.');
        }
      } else {
        // Handle non-200 status codes
        setState(() {
          healthNewsTitles = []; // Clear old news
          newsError = 'Failed to load news: Status ${response.statusCode}';
        });
        log('NewsAPI: Failed to load news with status: ${response.statusCode}');

        // You can add specific handling for common NewsAPI errors like 401 (invalid key), 429 (rate limited)
        if (response.statusCode == 401) {
             newsError = 'Failed to load news: Invalid API Key.';
             log('NewsAPI: API Key Unauthorized (401). Please check your key.');
        } else if (response.statusCode == 429) {
             newsError = 'Failed to load news: Rate Limited.';
             log('NewsAPI: Too Many Requests (429). Rate limit exceeded.');
        }
      }
    } catch (e) {
      // Handle network errors, JSON decoding errors, etc.
      setState(() {
        healthNewsTitles = []; // Clear old news
        newsError = 'Exception fetching news: $e';
      });
      log('NewsAPI: Exception during fetch: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            // Check if the route exists in your application's routes
            Navigator.pushNamed(context, '/reservation');
          } else if (index == 2) {
             // Check if the route exists in your application's routes
            Navigator.pushNamed(context, '/browse');
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
              // PM2.5 Section
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
                    // Display PM2.5 data or error
                    Text(
                      pm25Error.isNotEmpty ? pm25Error : pm25,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Health News Section Title
              const Text(
                "Health News",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Health News List or Error Message
              Expanded(
                child: newsError.isNotEmpty // Check if there's a news error
                    ? Center( // Center the error message if no news
                        child: Text(
                          newsError,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : healthNewsTitles.isEmpty // Check if news is still loading or empty list
                        ? Center(child: CircularProgressIndicator()) // Show loading indicator if titles list is empty and no error
                        : ListView.builder( // Build the list if titles are available
                            itemCount: healthNewsTitles.length,
                            itemBuilder: (context, index) {
                              return _buildHealthNewsTile(healthNewsTitles[index]);
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthNewsTile(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}