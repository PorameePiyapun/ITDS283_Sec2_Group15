import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Section: Common
  bool generalNotification = true;
  bool sound = false;
  bool vibrate = true;

  // Section: System & services update
  bool appUpdates = false;
  bool billReminder = true;
  bool promotion = false;
  bool discountAvailable = false;
  bool paymentRequest = false;

  // Section: Others
  bool newServiceAvailable = false;
  bool newTipsAvailable = true;

  // Helper method to build a switch tile
  Widget buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue,
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // Common Section
            Text(
              'Common',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Divider(),
            buildSwitch('General Notification', generalNotification,
                (value) => setState(() => generalNotification = value)),
            buildSwitch('Sound', sound, (value) => setState(() => sound = value)),
            buildSwitch('Vibrate', vibrate, (value) => setState(() => vibrate = value)),

            SizedBox(height: 20),

            // System & services update
            Text(
              'System & services update',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Divider(),
            buildSwitch('App updates', appUpdates,
                (value) => setState(() => appUpdates = value)),
            SizedBox(height: 20),

            // Others Section
            Text(
              'Others',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Divider(),
            buildSwitch('New Service Available', newServiceAvailable,
                (value) => setState(() => newServiceAvailable = value)),
            buildSwitch('New Tips Available', newTipsAvailable,
                (value) => setState(() => newTipsAvailable = value)),
          ],
        ),
      ),
    );
  }
}