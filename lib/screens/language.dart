import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String selectedLanguage = 'English';

  final List<String> languages = [
    'English',
    'Thai',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
    'Italian',
    'Portuguese',
    'Russian',
    'Arabic',
    'Hindi',
    'Bengali',
    'Urdu',
    'Turkish',
    'Vietnamese',
    'Polish',
    'Dutch',
    'Swedish',
    'Norwegian',
    'Danish',
    'Finnish',
    'Greek',
    'Hebrew',
    'Czech',
    'Hungarian',
    'Romanian',
    'Malay',
    'Indonesian'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Language",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Language',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedLanguage,
              items: languages
                  .map((lang) => DropdownMenuItem<String>(
                        value: lang,
                        child: Text(lang),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
