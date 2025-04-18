import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
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
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.edit, size: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Irvan Danmateo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('irvang@danmateo.com'),
          SizedBox(height: 20),
          Divider(),

          // ✅ แต่ละรายการลิงก์ไปยัง route ที่ต้องการ
          buildSettingItem(context, Icons.person, 'Account', '/account'),
          buildSettingItem(context, Icons.notifications, 'Notification', '/notification'),
          buildSettingItem(context, Icons.privacy_tip, 'Privacy policy', '/privacy'),
          buildSettingItem(context, Icons.language, 'Language', '/language'),
          buildSettingItem(context, Icons.contact_mail, 'Contact us', '/contactus'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Reservation'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Browse'),
        ],
      ),
    );
  }

  // ✅ เพิ่ม context เพื่อใช้กับ Navigator
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
