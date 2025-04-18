import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Privacy Policy",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "1. We collect and store user data, including name, contact details, and booking history. "
                "Your information is securely stored and used only for service improvements. We do not share your data "
                "with third parties without consent, except as required by law. By using our app, you agree to this policy. "
                "For concerns, contact us.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 20),
              Text(
                "2. Users have the right to access, update, or request deletion of their personal data. "
                "Requests can be made through the app’s support section.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 20),
              Text(
                "3. We implement security measures to protect user data from unauthorized access, alteration, or disclosure. "
                "However, users should take precautions to protect their login credentials.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
