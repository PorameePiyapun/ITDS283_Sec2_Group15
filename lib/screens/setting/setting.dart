import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacementNamed(context, '/'); // Navigate to login screen
              },
              child: Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.grey[700]),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Divider(),
          buildSettingItem(context, Icons.person, 'Account', '/account'),
          buildSettingItem(context, Icons.notifications, 'Notification', '/notification'),
          buildSettingItem(context, Icons.privacy_tip, 'Privacy policy', '/privacy'),
          buildSettingItem(context, Icons.language, 'Language', '/language'),
          buildSettingItem(context, Icons.contact_mail, 'Contact us', '/contactus'),
        ],
      ),
    );
  }

  Widget buildSettingItem(BuildContext context, IconData icon, String title, String routeName) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Center(child: Text("This is the Notification Page")),
    );
  }
}

// Other example pages for demonstration purposes
class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Account")),
      body: Center(child: Text("Account Page")),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policy")),
      body: Center(child: Text("Privacy Policy Page")),
    );
  }
}

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Language")),
      body: Center(child: Text("Language Page")),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us")),
      body: Center(child: Text("Contact Us Page")),
    );
  }
}

// Optional: For unknown routes (e.g., typos in the route names)
class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Unknown Route")),
      body: Center(child: Text("This route does not exist")),
    );
  }
}